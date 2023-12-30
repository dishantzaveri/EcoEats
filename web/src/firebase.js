// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyDA4lRhWya0vj422cRQyoTeROkWbuUA9o0",
    authDomain: "tourmate-b25c4.firebaseapp.com",
    projectId: "tourmate-b25c4",
    storageBucket: "tourmate-b25c4.appspot.com",
    messagingSenderId: "721687862384",
    appId: "1:721687862384:web:cb1bed54385ee91dcda8b5",
    measurementId: "G-ZHW7E5TJFV"
};
// Initialize Firebase

const app = initializeApp(firebaseConfig);
// Export firestore database
// It will be imported into your react app whenever it is needed
export const db = getFirestore(app);