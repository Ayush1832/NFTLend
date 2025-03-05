import CreateLoanRequest from "../components/CreateLoanRequest";
import RepayLoan from "../components/RepayLoan";

const Borrowing = () => {
  return (
    <div className="min-h-screen bg-gradient-to-r from-violet-600 to-fuchsia-600 flex flex-col items-center justify-center p-10">
      {/* Page Title */}
      <h1 className="text-5xl font-bold text-white text-center drop-shadow-lg mb-6">
        Borrow Against Your NFTs
      </h1>
      <p className="text-gray-100 text-lg max-w-2xl text-center drop-shadow-lg mb-10">
        Use your NFT as collateral to borrow cryptocurrency instantly.
      </p>

      {/* Loan Actions Section */}
      <div className="grid md:grid-cols-2 gap-10 w-full max-w-5xl">
        <div className="bg-gray-900 p-6 rounded-lg shadow-lg w-full text-white transition duration-300 transform hover:scale-105">
          <h2 className="text-2xl font-bold text-purple-300 text-center mb-4 drop-shadow-lg">
            Create Loan Request
          </h2>
          <CreateLoanRequest />
        </div>

        <div className="bg-gray-900 p-6 rounded-lg shadow-lg w-full text-white transition duration-300 transform hover:scale-105">
          <h2 className="text-2xl font-bold text-purple-300 text-center mb-4 drop-shadow-lg">
            Repay Loan
          </h2>
          <RepayLoan />
        </div>
      </div>
    </div>
  );
};

export default Borrowing;
