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

  File? selectedImage; // Use File for image selection

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: districtController,
              decoration: const InputDecoration(labelText: 'District'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    pro.setImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take Photo'),
                ),
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
            if (pro.selectedImage != null)
              Padding(
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
              ),
            ElevatedButton(
              onPressed: () {
                if (_validateFields()) {
                  editStudent(context);
                } else {
                  _showAlert(context, 'Please fill in all fields.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 248, 248, 248),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
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

  void editStudent(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final pro = Provider.of<BaseProvider>(context, listen: false);

    try {
      final editedName = nameController.text;
      final editedDistrict = districtController.text;
      final editedEmail = emailController.text;
      final editedNumber = numberController.text;
      final editedGender = genderController.text;

      await provider.imageAdder(File(pro.selectedImage!.path));

      final updatedStudent = StudentModel(
        name: editedName,
        district: editedDistrict,
        email: editedEmail,
        image: provider.downloadurl,
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
