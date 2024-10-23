import React from 'react';
import { useNavigate } from "react-router-dom";
import borrow from "../../public/Lending.png";
import lending from "../../public/Lending2.webp"

const LandingPage = () => {
  const navigate = useNavigate();

  const handleLendingClick = () => {
    navigate('/Lending'); 
  };
  const handleBorrowingClick = ()=>{
    navigate("/Borrowing")
  }

  return (
    <>
      <button onClick={handleLendingClick}>
        <img src={borrow} alt="tushar" />
        Lending
      </button>
      <button onClick={handleBorrowingClick}>
        <img src={lending} alt="tushar" />
        Borrow
      </button>
    </>
  );
};

export default LandingPage;
