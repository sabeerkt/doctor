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

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController emailController = TextEditingController(text: '@gmail.com');
  TextEditingController numberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String? selectedDistrict;
  String? selectedGender;

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
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: 'Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                          districtController.text = value!;
                        });
                      },
                      items: [
                        'Alappuzha',
                        'Ernakulam',
                        'Idukki',
                        'Kannur',
                        'Kasaragod',
                        'Kollam',
                        'Kottayam',
                        'Kozhikode',
                        'Malappuram',
                        'Palakkad',
                        'Pathanamthitta',
                        'Thrissur',
                        'Thiruvananthapuram',
                        'Wayanad'
                      ].map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'Number',
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                          genderController.text = value!;
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
                  ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        addStudent(context);
                        _clearFields();
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
    return nameController.text.isNotEmpty &&
        districtController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
        genderController.text.isNotEmpty;
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
    final name = nameController.text;
    final district = districtController.text;
    final email = emailController.text;
    final number = numberController.text;
    final gender = genderController.text;

    String imageUrl;
    if (pro.selectedImage != null) {
      await provider.imageAdder(File(pro.selectedImage!.path));
      imageUrl = provider.downloadurl;
    } else {
      imageUrl =
      'https://example.com/default_image.png'; // Replace with your default image URL
    }

    final student = StudentModel(
      name: name,
      district: district,
      email: email,
      image: imageUrl,
      number: number,
      gender: gender,
    );

    provider.addStudent(student);

    // Clear fields after adding student
    _clearFields();

    // Navigate to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNav(),
      ),
    );
  }

  void _clearFields() {
    nameController.clear();
    districtController.clear();
    emailController.clear();
    numberController.clear();
    genderController.clear();
    setState(() {
      selectedDistrict = null;
      selectedGender = null;
    });
  }
}
