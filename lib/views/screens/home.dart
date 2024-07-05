import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/controller/student_provider.dart';
import 'package:doctor/model/student_model.dart';
import 'package:doctor/views/add.dart';
import 'package:doctor/views/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedGender;
  String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Doctors'),
        backgroundColor: Colors.white,
        actions: [
          DropdownButton<String>(
            value: selectedGender,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
            },
            items: <String>['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(width: 20),
          DropdownButton<String>(
            value: selectedDistrict,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedDistrict = newValue;
              });
            },
            items: <String>[
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
              'Wayanad',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: Consumer<StudentProvider>(
          builder: (context, value, child) => Column(
            children: [
              StreamBuilder<QuerySnapshot<StudentModel>>(
                stream: (selectedGender != null && selectedDistrict != null)
                    ? value.getDataByGenderAndDistrict(
                        gender: selectedGender!,
                        district: selectedDistrict!,
                      )
                    : (selectedGender != null)
                        ? value.getDataByGender(selectedGender!)
                        : (selectedDistrict != null)
                            ? value.getDataByDistrict(selectedDistrict!)
                            : value.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Snapshot has error'));
                  } else {
                    List<QueryDocumentSnapshot<StudentModel>> studentsDoc =
                        snapshot.data?.docs ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: studentsDoc.length,
                        itemBuilder: (context, index) {
                          final data = studentsDoc[index].data();
                          final id = studentsDoc[index].id;
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                data.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Place: ${data.district.toString()}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Gender: ${data.gender.toString()}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: data.image != null
                                      ? NetworkImage(data.image!)
                                      : AssetImage('assets/add-friend (1).png'),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPage(
                                              id: id,
                                              student: data,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        value.deleteStudent(id);
                                        value.deleteImage(data.image);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
