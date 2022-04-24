import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFunctions functions =
    FirebaseFunctions.instanceFor(region: "us-central1");
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
