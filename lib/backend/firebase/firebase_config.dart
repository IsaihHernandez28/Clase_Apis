import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCd-HXq-osDt7GaRODF_3kiUMTi5jtc7i4",
            authDomain: "cinem-app-7lxnx5.firebaseapp.com",
            projectId: "cinem-app-7lxnx5",
            storageBucket: "cinem-app-7lxnx5.appspot.com",
            messagingSenderId: "1049228021692",
            appId: "1:1049228021692:web:75ea18129773180147a5b9"));
  } else {
    await Firebase.initializeApp();
  }
}
