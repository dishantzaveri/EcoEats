import React, { Component } from "react";

class Location extends Component {
  constructor(props) {
    super(props);

    this.state = {};
  }

  componentDidMount() {
    if (navigator.geolocation) {
      navigator.geolocation.watchPosition(function (position) {
        console.log(".........................");
        console.log(position);
        console.log(".........................");
        console.log("latitude is:", position.coords.latitude);
        console.log("longitude is:", position.coords.longitude);
      });
    }
  }

  render() {
    return (
      <div>
        <h4>Get Current Location</h4>
      </div>
    );
  }
}

export default Location;
