importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");


const firebaseConfig = {
  apiKey: "AIzaSyABkBdLx2p3VpUY8G1ZM3SLgy-mBT1aD7U",
  authDomain: "flutter-sample-project-318a4.firebaseapp.com",
  projectId: "flutter-sample-project-318a4",
  storageBucket: "flutter-sample-project-318a4.appspot.com",
  messagingSenderId: "1085982793073",
  appId: "1:1085982793073:web:a0ee5064cc8dfd3267ead0",
  measurementId: "G-1BFS0GS2V3"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});