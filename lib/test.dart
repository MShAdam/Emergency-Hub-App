import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = '';
  String _verificationId = '';

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          // User is automatically signed in
          // Handle successful sign-up here (e.g., navigate to home screen)
          print('User signed in automatically!');
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is invalid.');
          } else {
            print('An error occurred during verification: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
          print('Verification code sent to the phone number!');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
          print('Code retrieval timed out. Use resend token.');
        },
      );
    } catch (e) {
      print('Error verifying phone number: $e');
    }
  }

  Future<void> signInWithVerificationCode(
      String verificationId, String verificationCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: verificationCode);

      await _auth.signInWithCredential(credential);

      // User is signed in!
      // Handle successful sign-up here (e.g., navigate to home screen)
      print('User signed in with verification code!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        print('The provided verification code is invalid.');
      } else {
        print('An error occurred during sign in: ${e.message}');
      }
    } catch (e) {
      print('Error signing in with verification code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign-Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1 234-567-8900',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => verifyPhoneNumber(_phoneController.text.trim()),
              child: Text('Send Verification Code'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => signInWithVerificationCode(
                  _verificationId, _codeController.text.trim()),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
