importScripts('https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.3.1/firebase-messaging.js');

var firebaseConfig = {
  apiKey: "AIzaSyDRt5UTSp7hHOenFDpJY00XJHeK_-haQV8",
  authDomain: "decon-3545e.firebaseapp.com",
  databaseURL: "https://decon-3545e.firebaseio.com",
  projectId: "decon-3545e",
  storageBucket: "decon-3545e.appspot.com",
  messagingSenderId: "987240167971",
  appId: "1:987240167971:web:7720800de3aa4914940f96",
  measurementId: "G-QYVME5D7EW"
};

  firebase.initializeApp(firebaseConfig);
  
  const messaging = firebase.messaging();
  messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
  });