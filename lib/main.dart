import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:emergancyhub/signup.dart';
import 'package:emergancyhub/signin.dart';
import 'package:emergancyhub/test.dart';
import 'package:emergancyhub/home.dart';

import 'package:emergancyhub/onboard/onboarding1.dart';
import 'package:emergancyhub/onboard/onboarding2.dart';
import 'package:emergancyhub/onboard/onboarding3.dart';
import 'package:emergancyhub/onboard/splashscreen.dart';
import 'package:emergancyhub/forgetpassword/forgetpassword.dart';
import 'package:emergancyhub/forgetpassword/verfiy.dart';
import 'package:emergancyhub/forgetpassword/changepassword.dart';
import 'package:emergancyhub/services/standard_rooms.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with DefaultFirebaseOptions
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the initial route
      initialRoute: '/splashscreen',
      // Define the routes
      routes: {
        '/': (context) => SignUpScreen(),
        '/test': (context) => PhoneAuthScreen(),
        '/signup': (context) => SignUpScreen(),
        '/signin': (context) => SigninScreen(),
        '/home': (context) => homeScreen(),
        '/splashscreen': (context) => splashScreenScreen(),
        '/onboard1Screen': (context) => onboard1Screen(),
        '/onboard2Screen': (context) => onboard2Screen(),
        '/onboard3Screen': (context) => onboard3Screen(),
        '/forgetpassword': (context) => ForgetPasswordScreen(),
        '/verfiy': (context) => verfiyPasswordScreen(),
        '/changepassword': (context) => ChangePasswordScreen(),
        '/standardRooms': (context) => standardRoomsScreen(),
      },
    );
  }
}