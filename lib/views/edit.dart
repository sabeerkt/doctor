import 'dart:io';

import 'package:doctor/controller/baseprovider.dart';
import 'package:doctor/controller/student_provider.dart';
import 'package:doctor/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final StudentModel student;
  final String id;

  EditPage({
    Key? key,
    required this.student,
    required this.id,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name ?? '';
    districtController.text = widget.student.district ?? '';
    emailController.text = widget.student.email ?? '';
    numberController.text = widget.student.number ?? '';
    genderController.text = widget.student.gender ?? '';
    selectedImage = File(widget.student.image!);
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BaseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Doctor'),
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
                selectedImage != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            selectedImage!,
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
                    ElevatedButton.icon(
                      onPressed: () {
                        pro.setImage(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('Take Photo'),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        pro.setImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.photo),
                      label: Text('Choose from Gallery'),
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
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: districtController.text,
                    decoration: InputDecoration(
                      labelText: 'District',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(
                      labelText: 'Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: genderController.text,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        genderController.text = value!;
                      });
                    },
                    items: ['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        editStudent(context);
                      } else {
                        _showAlert(context, 'Please fill in all fields.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Save'),
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
          title: Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void editStudent(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final pro = Provider.of<BaseProvider>(context, listen: false);

    try {
      final editedName = nameController.text;
      final editedDistrict = districtController.text;
      final editedEmail = emailController.text;
      final editedNumber = numberController.text;
      final editedGender = genderController.text;

      String imageUrl;
      if (pro.selectedImage != null) {
        await provider.imageAdder(File(pro.selectedImage!.path));
        imageUrl = provider.downloadurl;
      } else {
        imageUrl = widget
            .student.image!; // Use existing image if no new image selected
      }

      final updatedStudent = StudentModel(
        name: editedName,
        district: editedDistrict,
        email: editedEmail,
        image: imageUrl,
        number: editedNumber,
        gender: editedGender,
      );

      provider.updateStudent(widget.id, updatedStudent);

      Navigator.pop(context);
    } catch (e) {
      print("Error updating student: $e");
    }
  }
}
