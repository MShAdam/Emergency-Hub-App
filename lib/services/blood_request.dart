import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class bloodRequestScreen extends StatefulWidget {
  @override
  State<bloodRequestScreen> createState() => _bloodRequestScreenState();
}

class _bloodRequestScreenState extends State<bloodRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  String? _genderSelected = "Male";
  String? _bloodTybeSelected = "A+";
  String? _hospitalSelected = "Air Force Specialized Hospital";
  DateTime _reservationDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _reservationDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (picked != null && picked != _reservationDate) {
      setState(() {
        _reservationDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final databaseReference = FirebaseDatabase.instance.reference();

      databaseReference.child('/requests/bloodRequest').push().set({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'age': _ageController.text,
        'hospital': _hospitalSelected,
        'gender': _genderSelected,
        'reservationDate': _reservationDate.toIso8601String(),
        'bloodType': _bloodTybeSelected,
        'room': 0,
        'accepted': false,
        'removed': false
      }).then((value) {
        print("Data saved successfully.");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Info"),
              content: const Text("Request Sent Succesfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
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
                              top: 50.0,
                              child: Image.asset(
                                  'assets/img/logo.png'), // Your foreground image
                            ),
                            Positioned(
                              left: 10.0,
                              top: 50.0,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                              ), // Your foreground image
                            ),
                            Positioned(
                                left: 10.0,
                                top: 130.0,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/img/Blood request.png'), // Replace with your image path
                                      const Text(
                                        'Blood Request',
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                )),
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
                                'Name:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  fillColor: AppColors
                                      .backgroundColor, // Set background color here
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // Border radius here
                                    borderSide:
                                        BorderSide.none, // No border side
                                  ),
                                ),
                                style: const TextStyle(
                                    color:
                                        AppColors.WhiteColor), // Cursor color
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Phone Number:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  fillColor: AppColors
                                      .backgroundColor, // Set background color here
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // Border radius here
                                    borderSide:
                                        BorderSide.none, // No border side
                                  ),
                                ),
                                style: const TextStyle(
                                    color:
                                        AppColors.WhiteColor), // Cursor color
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  if (value.length != 11) {
                                    return "Please entar a valid number !!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Age:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                controller: _ageController,
                                decoration: InputDecoration(
                                  fillColor: AppColors
                                      .backgroundColor, // Set background color here
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // Border radius here
                                    borderSide:
                                        BorderSide.none, // No border side
                                  ),
                                ),
                                style: const TextStyle(
                                    color:
                                        AppColors.WhiteColor), // Cursor color
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                validator: (value) {
                                  int? parsedValue = int.tryParse(value ?? "");
                                  if (parsedValue == null ||
                                      parsedValue < 1 ||
                                      parsedValue > 120) {
                                    return 'Please enter a age between 1 and 120';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Blood Type:',
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
                                  value: _bloodTybeSelected ?? "A+",
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _bloodTybeSelected = newValue;
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
                                  items: <String>[
                                    'A+',
                                    'A-',
                                    'B+',
                                    'B-',
                                    'AB+',
                                    'AB-',
                                    'O+',
                                    'O-'
                                  ].map<DropdownMenuItem<String>>(
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Gender:',
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
                                  value: _genderSelected ?? "Male",
                                  // value: _genderSelected,s
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _genderSelected = newValue;
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
                                  items: <String>['Male', 'Female']
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Reservation Date:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            SizedBox(
                              height: 65.0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          48)),
                                  child: Text(
                                    '${_reservationDate.year}-${_reservationDate.month}-${_reservationDate.day}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1)),
                                  ),
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
                            const SizedBox(height: 5.0),
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
                                  value: _hospitalSelected ??
                                      "Air Force Specialized Hospital",
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _hospitalSelected = newValue;
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
                                  items: <String>[
                                    'Air Force Specialized Hospital',
                                    'As-Salam International Hospital',
                                    'Heliopolis Hospital'
                                  ].map<DropdownMenuItem<String>>(
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
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 20.0),
                            //   child: TextField(
                            //     controller: _addressController,
                            //     decoration: InputDecoration(
                            //       fillColor: AppColors
                            //           .backgroundColor, // Set background color here
                            //       filled: true,
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(
                            //             25.0), // Border radius here
                            //         borderSide:
                            //             BorderSide.none, // No border side
                            //       ),
                            //     ),
                            //     style: const TextStyle(
                            //         color:
                            //             AppColors.WhiteColor), // Cursor color
                            //   ),
                            // ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _submitForm(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.backgroundColor,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 48)),
                                child: const Text(
                                  'Send',
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
