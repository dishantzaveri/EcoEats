// import React, { useState } from "react";
// import { db } from "./firebase"; // Adjust the path according to your project structure

// const SendData = () => {
//   const [name, setName] = useState("");
//   const [latitude, setLatitude] = useState("");
//   const [longitude, setLongitude] = useState("");

//   const handleSubmit = async (e) => {
//     e.preventDefault();

//     try {
//       await db.collection("orders").add({
//         name,
//         latitude,
//         longitude,
//       });
//       console.log("Document successfully written!");
//     } catch (error) {
//       console.error("Error writing document: ", error);
//     }
//   };

//   return (
//     <div>
//       <form onSubmit={handleSubmit}>
//         <input
//           type="text"
//           value={name}
//           onChange={(e) => setName(e.target.value)}
//           placeholder="Name"
//         />
//         <input
//           type="text"
//           value={latitude}
//           onChange={(e) => setLatitude(e.target.value)}
//           placeholder="Latitude"
//         />
//         <input
//           type="text"
//           value={longitude}
//           onChange={(e) => setLongitude(e.target.value)}
//           placeholder="Longitude"
//         />
//         <button type="submit">Submit</button>
//       </form>
//     </div>
//   );
// };

// export default SendData;
