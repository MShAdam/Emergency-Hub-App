import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class standardRoomsScreen extends StatefulWidget {
  @override
  State<standardRoomsScreen> createState() => _standardRoomsScreenState();
}

class _standardRoomsScreenState extends State<standardRoomsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _areaSelected;
  DateTime _reservationDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _reservationDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _reservationDate) {
      setState(() {
        _reservationDate = picked;
      });
    }
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final databaseReference = FirebaseDatabase.instance.reference();

      databaseReference.child('/requests/standardRooms').push().set({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'age': _ageController.text,
        'address': _addressController.text,
        'gender': _areaSelected,
        'reservationDate': _reservationDate.toIso8601String(),
        'accepted': false,
        'removed': false,
      }).then((value) {
        print("Data saved successfully.");
      }).catchError((error) {
        print("Failed to save data: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
                body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.asset('assets/img/headimg.jpg'),
                            Positioned(
                              right: 10.0,
                              top: 25.0,
                              child: Image.asset(
                                  'assets/img/logo.png'), // Your foreground image
                            ),
                            Positioned(
                              left: 10.0,
                              top: 130.0,
                              child: Image.asset(
                                'assets/img/standard_rooms.png',
                                // fit: BoxFit.cover, // Choose fit mode
                                width: screenSize.width *
                                    0.25, // Set desired width
                                height: screenSize.height *
                                    0.1, // Set desired height
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.85, // Ensures 85% width
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align items to the start (left side)
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Area:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors
                                      .backgroundColor, // Background fill color
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: DropdownButton<String>(
                                  itemHeight: 65,
                                  dropdownColor: AppColors.backgroundColor,
                                  value: _areaSelected,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _areaSelected = newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  underline:
                                      const SizedBox(), // Remove underline
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: AppColors
                                          .WhiteColor), // Dropdown arrow color
                                  style: const TextStyle(
                                      color: AppColors
                                          .WhiteColor), // Dropdown text color
                                  items: <String>['Nasr City', 'The 5th Settlement', 'Al maadi']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Hospital:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors
                                      .backgroundColor, // Background fill color
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: DropdownButton<String>(
                                  itemHeight: 65,
                                  dropdownColor: AppColors.backgroundColor,
                                  value: _areaSelected,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _areaSelected = newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  underline:
                                      const SizedBox(), // Remove underline
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: AppColors
                                          .WhiteColor), // Dropdown arrow color
                                  style: const TextStyle(
                                      color: AppColors
                                          .WhiteColor), // Dropdown text color
                                  items: <String>['Nasr City', 'The 5th Settlement', 'Al maadi']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),


                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: ElevatedButton(
                                onPressed: () => _submitForm(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.backgroundColor,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 48)),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))));
  }
}

class AppColors {
  static const primaryColor = Color(0xff40bfff);
  static const textColor = Color(0xff223263);
  static const text2_Color = Color(0xff9098B1);
  static const DiscountColor = Color(0xffFB7181);
  static const borderColor = Color(0xffEBF0FF);
  static const ngmaColor = Color(0xffFFC833);
  static const WhiteColor = Colors.white;
  static const backgroundColor = Color(0xff0870A7);
}

class LoginIcon {
  static const email = Icons.email;
  static const lock = Icons.lock_outline;
  static const visibility = Icons.visibility_outlined;
  static const account = Icons.account_box_outlined;
  static const phone = Icons.phone;
}
