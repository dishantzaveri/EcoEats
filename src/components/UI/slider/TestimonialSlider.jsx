import React from "react";
import Slider from "react-slick";

import ava01 from "../../../assets/images/ava-1.jpg";
import ava02 from "../../../assets/images/ava-2.jpg";
import ava03 from "../../../assets/images/ava-3.jpg";

import "../../../styles/slider.css";

const TestimonialSlider = () => {
  const settings = {
    dots: true,
    autoplay: true,
    infinite: true,
    speed: 1000,
    autoplaySpeed: 3000,
    swipeToSlide: true,
    slidesToShow: 1,
    slidesToScroll: 1,
  };
  return (
    <Slider {...settings}>
      <div>
        <p className="review__text">
          "Since discovering Eco Eats, our family dinners have transformed. The
          quality of ingredients is top-notch, and knowing that we're eating
          sustainably makes every meal feel special. Plus, the eco-friendly
          packaging is a huge bonus for us as we strive to reduce our
          environmental footprint. We're not just enjoying great food; we're
          part of a meaningful cause."
        </p>
        <div className=" slider__content d-flex align-items-center gap-3 ">
          <img src={ava01} alt="avatar" className=" rounded" />
          <h6>Vividha Jagtap</h6>
        </div>
      </div>
      <div>
        <p className="review__text">
          "As someone with a busy lifestyle, finding time to cook healthy meals
          was always a struggle. Eco Eats has been a lifesaver with their quick
          and efficient delivery service. The fact that they focus on reducing
          carbon emissions with optimized delivery routes makes me feel good
          about my choice. It's rare to find a service that's fast, reliable,
          and genuinely committed to sustainability."
        </p>
        <div className="slider__content d-flex align-items-center gap-3 ">
          <img src={ava02} alt="avatar" className=" rounded" />
          <h6>Dishant Zaveri</h6>
        </div>
      </div>
      <div>
        <p className="review__text">
          "What I love about Eco Eats is the sense of community they foster.
          It's not just about delivering food; it’s about supporting local
          farmers and giving back to environmental causes. Their commitment to
          sustainability and community support really shines through in
          everything they do. Each order feels like I'm contributing to a
          larger, positive impact."
        </p>
        <div className="slider__content d-flex align-items-center gap-3 ">
          <img src={ava03} alt="avatar" className=" rounded" />
          <h6>Palak Uppal</h6>
        </div>
      </div>
    </Slider>
  );
};

export default TestimonialSlider;
