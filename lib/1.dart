import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  void _updateNotifApp(String path) {
    _database.child(path).update({
      'notifapp': false,
    }).then((_) {
      print('Notification app status updated to false');
    }).catchError((error) {
      print('Failed to update notification app status: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Firebase Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Provide the specific path to the record you want to update
            _updateNotifApp('/requests/ambulance/-NxwT9UJMnDVmQLVVzDj');
          },
          child: Text('Update Notification Status'),
        ),
      ),
    );
  }
}
