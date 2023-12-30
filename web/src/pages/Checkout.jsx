import React, { useState } from "react";
import { useSelector } from "react-redux";
import { Col, Container, Row } from "reactstrap";
import Helmet from "../components/Helmet/Helmet";
import CommonSection from "../components/UI/common-section/CommonSection";
import "../styles/checkout.css";

import { addDoc, collection } from "firebase/firestore";
import { db } from "../firebase";

const Checkout = () => {
  const [enterName, setEnterName] = useState("");
  const [enterEmail, setEnterEmail] = useState("");
  const [enterNumber, setEnterNumber] = useState("");
  const [enterCity, setEnterCity] = useState("");
  const [postalCode, setPostalCode] = useState("");

  const shippingInfo = [];
  const cartTotalAmount = useSelector((state) => state.cart.totalAmount);
  const shippingCost = 30;

  let lat;
  let lng;

  const totalAmount = cartTotalAmount + Number(shippingCost);

  const names = [
    "Mike Nefkens",
    "Denise Doyle",
    "Adeel Manzoor",
    "David Kenzer",
    "Jason Jameson",
  ];
  const emails = [
    "dummyForPich@here.com",
    "eatEasy@here.com",
    "hello@here.com",
    "test@here.com",
    "pitch@here.com",
  ];

  const destinationAddresses = [
    "Energy Building, IIT Bombay",
    "SAC, IIT Bombay",
    "Gulmohor, IIT Bombay",
    "Convo, IIT Bombay",
    "Laxmi Next Pure Veg Restaurant, Powai",
  ];

  const prices = ["2000", "1500", "500", "300", "2500"];

  const quantities = ["1", "2", "3", "1", "1"];

  const { setDefaults, fromAddress } = require("react-geocode");

  setDefaults({
    key: "AIzaSyAMn8HxTpw1qZDpqOAyNwIE5BoAKVKEFr0",
    language: "en",
    region: "es",
  });
  fromAddress(
    destinationAddresses[
      Math.floor(Math.random() * destinationAddresses.length)
    ]
  )
    .then(async ({ results }) => {
      ({ lat, lng } = await results[0].geometry.location);
      console.log(lat, lng);
    })
    .catch(console.error);

  const addOrder = async (e) => {
    e.preventDefault();

    try {
      const docRef = await addDoc(collection(db, "orders"), {
        description: "Spicy Arrabbiata penne with fresh Italian herbs",
        destinationAddress:
          destinationAddresses[
            Math.floor(Math.random() * destinationAddresses.length)
          ],
        sourceAddress:
          destinationAddresses[
            Math.floor(Math.random() * destinationAddresses.length)
          ],
        sourceLatitude: lat,
        sourceLongitude: lng,
        destinationLatitude: 19.1302435,
        destinationLongitude: 72.9186734,
        destinationName:
          destinationAddresses[
            Math.floor(Math.random() * destinationAddresses.length)
          ],
        destinationPhoneNumber: "9090909090",
        imageUrl: "",
        name: names[Math.floor(Math.random() * names.length)],
        price: prices[Math.floor(Math.random() * prices.length)],
        quantity: quantities[Math.floor(Math.random() * quantities.length)],
        sourceName: names[Math.floor(Math.random() * names.length)],
        sourcePhoneNumber: "9090909090",
        status: "Cooking",
      });
      console.log("Document written with ID: ", docRef.id);
    } catch (e) {
      console.error("Error adding document: ", e);
    }
  };

  return (
    <Helmet title="Checkout">
      <CommonSection title="Checkout" />
      <section>
        <Container>
          <Row>
            <Col lg="8" md="6">
              <h6 className="mb-4">Shipping Address</h6>
              <form className="checkout__form">
                <div className="form__group">
                  <input
                    type="text"
                    placeholder="Enter your name"
                    value={names[Math.floor(Math.random() * names.length)]}
                    required
                    onChange={(e) => setEnterName(e.target.value)}
                  />
                </div>

                <div className="form__group">
                  <input
                    type="email"
                    placeholder="Enter your email"
                    // Set a default value pre filled
                    value={emails[Math.floor(Math.random() * emails.length)]}
                    required
                    onChange={(e) => setEnterEmail(e.target.value)}
                  />
                </div>
                <div className="form__group">
                  <input
                    type="number"
                    placeholder="Phone number"
                    value="9090909090"
                    required
                    onChange={(e) => setEnterNumber(e.target.value)}
                  />
                </div>
                <div className="form__group">
                  <input
                    type="text"
                    placeholder="Desitnation Address"
                    value={
                      destinationAddresses[
                        Math.floor(Math.random() * destinationAddresses.length)
                      ]
                    }
                    required
                    onChange={(e) => setEnterCity(e.target.value)}
                  />
                </div>
                <div className="form__group">
                  <input
                    type="number"
                    placeholder="Postal code"
                    value="400076"
                    required
                    onChange={(e) => setPostalCode(e.target.value)}
                  />
                </div>
                {/* <button className="addTOCart__btn">
                  <Link to="/location">Payment</Link>
                </button> */}
                <button
                  type="submit"
                  className="addTOCart__btn"
                  onClick={addOrder}
                >
                  <Link to="/location">Place Order</Link>
                </button>
              </form>
            </Col>

            <Col lg="4" md="6">
              <div className="checkout__bill">
                <h6 className="d-flex align-items-center justify-content-between mb-3">
                  Subtotal: <span>${cartTotalAmount}</span>
                </h6>
                <h6 className="d-flex align-items-center justify-content-between mb-3">
                  Shipping: <span>${shippingCost}</span>
                </h6>
                <div className="checkout__total">
                  <h5 className="d-flex align-items-center justify-content-between">
                    Total: <span>${totalAmount}</span>
                  </h5>
                </div>
              </div>
            </Col>
          </Row>
        </Container>
      </section>
    </Helmet>
  );
};

export default Checkout;
