import React from "react";

import Routes from "../../routes/Routers.js";
import Footer from "../Footer/Footer.jsx";
import Header from "../Header/Header.jsx";

import { useSelector } from "react-redux";
import Carts from "../UI/cart/Carts.jsx";

const Layout = () => {
  const showCart = useSelector((state) => state.cartUi.cartIsVisible);
  return (
    <div>
      <Header />

      {showCart && <Carts />}

      <div>
        <Routes />
      </div>
      <Footer />
    </div>
  );
};

export default Layout;
