// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MicroloanPlatform is Ownable, ERC721Holder, ReentrancyGuard {
     
    address public admin;
    uint256 public platformFeePercent;
    uint256 public platformFeesCollected;
    
     
    uint256 public constant HUNDRED_PERCENT = 100;
    uint256 public constant MAX_PLATFORM_FEE = 20;  
    
    struct LoanRequest {
        address borrower;
        address collateralToken;
        uint256 collateralId;   
        uint256 loanAmount;
        uint256 interestRate;  
        uint256 duration;
        uint256 startTime;
        address lender;
        bool isActive;
        bool isFunded;
        bool isRepaid;
        bool isLiquidated;
    }
    
    // Storage
    mapping(uint256 => LoanRequest) public loanRequests;
    uint256 public totalLoans;
    mapping(address => uint256[]) public userLoans; // Borrower -> loan IDs
    mapping(address => uint256[]) public lenderLoans; // Lender -> loan IDs
    
    // Events
    event LoanRequestCreated(
        uint256 indexed loanId,
        address indexed borrower,
        address collateralToken,
        uint256 collateralId,
        uint256 loanAmount,
        uint256 interestRate,
        uint256 duration
    );
    event LoanFunded(uint256 indexed loanId, address indexed lender, uint256 amount);
    event LoanRepaid(uint256 indexed loanId, uint256 repaymentAmount);
    event LoanLiquidated(uint256 indexed loanId, address indexed lender);
    event PlatformFeeUpdated(uint256 newFeePercent);
    event FeesWithdrawn(uint256 amount);
    
    constructor() Ownable(msg.sender) {
        admin = msg.sender;
        platformFeePercent = 5;
    }
    
    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
    
    modifier validLoanId(uint256 loanId) {
        require(loanId < totalLoans, "Invalid loan ID");
        _;
    }
    
    modifier loanExists(uint256 loanId) {
        require(loanRequests[loanId].isActive, "Loan does not exist");
        _;
    }
    
    
    function createLoanRequest(
        address collateralToken,
        uint256 collateralId,
        uint256 loanAmount,
        uint256 interestRate,
        uint256 duration
    ) external nonReentrant returns (uint256) {
        require(collateralToken != address(0), "Invalid collateral token");
        require(loanAmount > 0, "Invalid loan amount");
        require(interestRate > 0 && interestRate <= HUNDRED_PERCENT, "Invalid interest rate");
        require(duration > 0, "Invalid duration");
        
         
        IERC721(collateralToken).safeTransferFrom(msg.sender, address(this), collateralId);
        require(IERC721(collateralToken).ownerOf(collateralId)==address(this),"Transfer failed");
        
        uint256 loanId = totalLoans;
        
        LoanRequest storage loan = loanRequests[loanId];
        loan.borrower = msg.sender;
        loan.collateralToken = collateralToken;
        loan.collateralId = collateralId;
        loan.loanAmount = loanAmount;
        loan.interestRate = interestRate;
        loan.duration = duration;
        loan.isActive = true;
        
        userLoans[msg.sender].push(loanId);
        totalLoans++;
        
        emit LoanRequestCreated(
            loanId,
            msg.sender,
            collateralToken,
            collateralId,
            loanAmount,
            interestRate,
            duration
        );
        
        return loanId;
    }
    
    function fundLoan(uint256 loanId) 
        external 
        payable 
        nonReentrant 
        validLoanId(loanId) 
        loanExists(loanId) 
    {
        LoanRequest storage loan = loanRequests[loanId];
        require(!loan.isFunded, "Already funded");
        require(msg.value == loan.loanAmount, "Incorrect amount");
        require(loan.borrower != msg.sender, "Cannot fund own loan");
        
        loan.isFunded = true;
        loan.isActive = true;
        loan.lender = msg.sender;
        loan.startTime = block.timestamp;
        
        lenderLoans[msg.sender].push(loanId);
        
        
        payable(loan.borrower).transfer(msg.value);
        
        emit LoanFunded(loanId, msg.sender, msg.value);
    }
    
    function repayLoan(uint256 loanId) 
        external 
        payable 
        nonReentrant 
        validLoanId(loanId) 
        loanExists(loanId) 
    {
        LoanRequest storage loan = loanRequests[loanId];
        require(loan.isFunded, "Not funded");
        require(!loan.isRepaid, "Already repaid");
        require(!loan.isLiquidated, "Already liquidated");
        require(msg.sender == loan.borrower, "Not borrower");
        require(block.timestamp <= loan.startTime + loan.duration, "Loan expired");
        
        uint256 repaymentAmount = calculateRepaymentAmount(loanId);
        require(msg.value == repaymentAmount, "Incorrect amount");
        
        loan.isRepaid = true;
        loan.isActive = false;
        
        
        uint256 interest = repaymentAmount - loan.loanAmount;
        uint256 platformFee = (interest * platformFeePercent) / HUNDRED_PERCENT;
        platformFeesCollected += platformFee;
        
         
        IERC721(loan.collateralToken).safeTransferFrom(address(this), loan.borrower, loan.collateralId);
        
    
        payable(loan.lender).transfer(msg.value - platformFee);
        
        emit LoanRepaid(loanId, repaymentAmount);
    }
    
    function liquidateLoan(uint256 loanId) 
        external 
        nonReentrant 
        validLoanId(loanId) 
        loanExists(loanId) 
    {
        LoanRequest storage loan = loanRequests[loanId];
        require(loan.isFunded, "Not funded");
        require(!loan.isRepaid, "Already repaid");
        require(!loan.isLiquidated, "Already liquidated");
        require(msg.sender == loan.lender, "Not lender");
        require(block.timestamp > loan.startTime + loan.duration, "Not expired");
        
        loan.isLiquidated = true;
        loan.isActive = false;
        
        
        IERC721(loan.collateralToken).safeTransferFrom(address(this), loan.lender, loan.collateralId);
        
        emit LoanLiquidated(loanId, loan.lender);
    }
    
  
    function calculateRepaymentAmount(uint256 loanId) 
        public 
        view 
        validLoanId(loanId) 
        returns (uint256) 
    {
        LoanRequest storage loan = loanRequests[loanId];
        uint256 interest = (loan.loanAmount * loan.interestRate) / HUNDRED_PERCENT;
        return loan.loanAmount + interest;
    }
    
    function getActiveLoanRequests() external view returns (uint256[] memory) {
        uint256[] memory activeLoans = new uint256[](totalLoans);
        uint256 activeCount = 0;
        
        for (uint256 i = 0; i < totalLoans; i++) {
            if (loanRequests[i].isActive && !loanRequests[i].isFunded) {
                activeLoans[activeCount] = i;
                activeCount++;
            }
        }
        
        // Create correctly sized array
        uint256[] memory result = new uint256[](activeCount);
        for (uint256 i = 0; i < activeCount; i++) {
            result[i] = activeLoans[i];
        }
        
        return result;
    }
    
    function getUserLoans(address user) external view returns (uint256[] memory) {
        return userLoans[user];
    }
    
    function getLenderLoans(address lender) external view returns (uint256[] memory) {
        return lenderLoans[lender];
    }
    
    
    function setPlatformFee(uint256 newFeePercent) external onlyAdmin {
        require(newFeePercent <= MAX_PLATFORM_FEE, "Fee too high");
        platformFeePercent = newFeePercent;
        emit PlatformFeeUpdated(newFeePercent);
    }
    
    function withdrawFees() external onlyAdmin nonReentrant {
    uint256 amount = platformFeesCollected;
    require(amount > 0, "No fees to withdraw");

    platformFeesCollected = 0;
    
  
    (bool success, ) = admin.call{value: amount}("");
    require(success, "Transfer failed");

    emit FeesWithdrawn(amount);
}

}