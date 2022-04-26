import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
// FirebaseDynamicLinks fBDynamicLink = FirebaseDynamicLinks.instance;
