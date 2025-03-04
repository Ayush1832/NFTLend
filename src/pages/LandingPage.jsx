import { useNavigate } from "react-router-dom";
import logo from "../../public/logo.jpg";
import { Button } from "antd";

const LandingPage = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-black text-white p-10 flex flex-col items-center">
      {/* Navbar */}
      <div className="w-full flex justify-between items-center max-w-6xl">
        <img src={logo} alt="NFTLend Logo" className="w-24" />
        <button className="bg-purple-600 px-4 py-2 rounded-lg">Connect Wallet</button>
      </div>

      {/* Hero Section */}
      <div className="text-center mt-16">
        <h1 className="text-6xl font-bold text-purple-400">
          Unlock the Value of Your NFTs
        </h1>
        <p className="text-gray-400 mt-4 text-lg max-w-2xl mx-auto">
          Get instant loans using your NFTs as collateral. Our secure platform
          connects borrowers with lenders in the NFT space.
        </p>
        <div className="mt-6 flex justify-center gap-4">
          <Button
            className="bg-purple-500 text-white px-6 py-3 rounded-lg text-lg"
            onClick={() => navigate("/Borrowing")}
          >
            Borrow Now →
          </Button>
          <Button
            className="bg-gray-800 text-white px-6 py-3 rounded-lg text-lg"
            onClick={() => navigate("/Lending")}
          >
            Start Lending
          </Button>
        </div>
      </div>

      {/* Features Section */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mt-20 max-w-5xl">
        <div className="bg-gray-900 p-6 rounded-lg text-center">
          <h2 className="text-xl font-bold text-white">Instant Loans</h2>
          <p className="text-gray-400 mt-2">
            Get quick access to loans using your NFTs as collateral.
          </p>
        </div>
        <div className="bg-gray-900 p-6 rounded-lg text-center">
          <h2 className="text-xl font-bold text-white">Secure Platform</h2>
          <p className="text-gray-400 mt-2">
            Smart contract-based lending with maximum security.
          </p>
        </div>
        <div className="bg-gray-900 p-6 rounded-lg text-center">
          <h2 className="text-xl font-bold text-white">Competitive Rates</h2>
          <p className="text-gray-400 mt-2">
            Find the best lending rates in the NFT market.
          </p>
        </div>
      </div>
    </div>
  );
};

export default LandingPage;
