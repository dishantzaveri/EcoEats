import Map from './Maps';
import React, { useState } from 'react';
import RestaurantList from './RestaurantList';
const apikey = 'cuj0o7HVeJ7R6ylDkWbuOw7MSUZlwS4cM-2CgRuVa-4'
// Austurvöllur square in Reykjavik
const userPosition = { lat: 64.1472, lng: -21.9398 };
// Austurvöllur square in Reykjavik
const restaurantList = [
  {
    name: "The Fish Market",
    location: { lat: 64.1508, lng: -21.9536 },
  },
  {
    name: "Bæjarins Beztu Pylsur",
    location: { lat: 64.1502, lng: -21.9519 },
  },
  {
    name: "Grillmarkadurinn",
    location: { lat: 64.1475, lng: -21.9347 },
  },
  {
    name: "Kol Restaurant",
    location: { lat: 64.1494, lng: -21.9337 },
  },
];



function Loc() {
  const [restaurantPosition, setRestaurantPosition] = useState(null);

  const onClickHandler_ = (location) => {
    setRestaurantPosition(location);
  };

  return (
    <div>
      <RestaurantList list={restaurantList} onClickHandler={onClickHandler_} />
      <Map
        apikey={apikey}
        userPosition={userPosition}
        restaurantPosition={restaurantPosition}
      />
    </div>
  );
}

export default Loc;
