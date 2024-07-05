import 'dart:io';

import 'package:doctor/controller/baseprovider.dart';
import 'package:doctor/controller/student_provider.dart';
import 'package:doctor/model/student_model.dart';
import 'package:doctor/views/screens/home.dart';
import 'package:doctor/views/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  // List of districts
  final List<String> districts = [
    'Alappuzha ',
    'Ernakulam',
    'Idukki',
    'Kannur ',
    'Kasaragod',
    'Kollam ',
    'Kottayam',
    'Kozhikode ',
    'Malappuram',
    'Palakkad ',
    'Pathanamthitta',
    'Thrissur ',
    'Thiruvananthapuram ',
    'Wayanad',
  ];

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? selectedDistrict; // To store selected district
  String? selectedGender; // To store selected gender

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Check if pro.selectedImage is not null, show the image; otherwise show a container
                pro.selectedImage != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            pro.selectedImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                // Row for the button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        pro.setImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('Choose from Gallery'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Name TextFormField
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: widget.nameController,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: 'Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // District Dropdown
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedDistrict,
                      decoration: const InputDecoration(
                        labelText: 'District',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                          widget.districtController.text = value!;
                        });
                      },
                      items: widget.districts.map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Email TextFormField
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: widget.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Number TextFormField
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: widget.numberController,
                      decoration: const InputDecoration(
                        labelText: 'Number',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Gender Dropdown
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedGender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                          widget.genderController.text = value!;
                        });
                      },
                      items: ['Male', 'Female'].map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        addStudent(context);
                      } else {
                        _showAlert(
                            context, 'Please fill in all required fields.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateFields() {
    return widget.nameController.text.isNotEmpty &&
        widget.districtController.text.isNotEmpty &&
        widget.emailController.text.isNotEmpty &&
        widget.numberController.text.isNotEmpty &&
        widget.genderController.text.isNotEmpty;
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addStudent(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final pro = Provider.of<BaseProvider>(context, listen: false);
    final name = widget.nameController.text;
    final district = widget.districtController.text;
    final email = widget.emailController.text;
    final number = widget.numberController.text;
    final gender = widget.genderController.text;

    await provider.imageAdder(File(pro.selectedImage!.path));

    final student = StudentModel(
      name: name,
      district: district,
      email: email,
      image: provider.downloadurl,
      number: number,
      gender: gender,
    );

    provider.addStudent(student);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNav(),
      ),
    );
  }
}
