import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Controller.dart';
AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSign = GoogleSignIn();
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

