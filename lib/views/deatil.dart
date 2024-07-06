import 'package:doctor/model/student_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final StudentModel student;

  const DetailPage({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name ?? 'Student Detail'),
        backgroundColor: Colors.green, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: student.image != null
                      ? NetworkImage(student.image!)
                      : AssetImage('assets/add-friend (1).png'),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.name ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "District",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.district ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "Email",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.email ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "Number",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.number ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "Gender",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.gender ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
