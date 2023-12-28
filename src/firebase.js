import { initializeApp } from "firebase/app";
import { getFirestore } from "@firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyDA4lRhWya0vj422cRQyoTeROkWbuUA9o0",
  authDomain: "tourmate-b25c4.firebaseapp.com",
  projectId: "tourmate-b25c4",
  storageBucket: "tourmate-b25c4.appspot.com",
  messagingSenderId: "721687862384",
  appId: "1:721687862384:web:3a6cdc2f104a3476cda8b5",
  measurementId: "G-1ZC5PV5R3Q",
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
export { db };
export const firestore = getFirestore(app);
