import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/controller/student_provider.dart';
import 'package:doctor/model/student_model.dart';
import 'package:doctor/views/add.dart';
import 'package:doctor/views/deatil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedGender = 'All';
  String? selectedDistrict = 'All';
  bool isGridView = false;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Doctors',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<StudentProvider>(
          builder: (context, value, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search doctors...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (query) {
                          setState(() {
                            searchQuery = query;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    DropdownButton<String>(
                      value: selectedGender,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      items: <String>['All', 'Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 16),
                    DropdownButton<String>(
                      value: selectedDistrict,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDistrict = newValue;
                        });
                      },
                      items: <String>[
                        'All',
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
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<StudentModel>>(
                  stream: (selectedGender != null &&
                          selectedGender != 'All' &&
                          selectedDistrict != null &&
                          selectedDistrict != 'All')
                      ? value.getDataByGenderAndDistrict(
                          gender: selectedGender!,
                          district: selectedDistrict!,
                        )
                      : (selectedGender != null && selectedGender != 'All')
                          ? value.getDataByGender(selectedGender!)
                          : (selectedDistrict != null &&
                                  selectedDistrict != 'All')
                              ? value.getDataByDistrict(selectedDistrict!)
                              : value.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Snapshot has error'));
                    } else {
                      List<QueryDocumentSnapshot<StudentModel>> studentsDoc =
                          snapshot.data?.docs ?? [];

                      // Filter the list based on search query
                      studentsDoc = studentsDoc.where((doc) {
                        final data = doc.data();
                        return data.name
                                ?.toLowerCase()
                                .contains(searchQuery.toLowerCase()) ??
                            false;
                      }).toList();

                      return isGridView
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: studentsDoc.length,
                              itemBuilder: (context, index) {
                                return _buildDoctorCard(
                                    studentsDoc[index], value);
                              },
                            )
                          : ListView.builder(
                              itemCount: studentsDoc.length,
                              itemBuilder: (context, index) {
                                return _buildDoctorListItem(
                                    studentsDoc[index], value);
                              },
                            );
                    }
                  },
                ),
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
              builder: (context) => AddEditPage(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDoctorCard(
      QueryDocumentSnapshot<StudentModel> doc, StudentProvider value) {
    final data = doc.data();
    final id = doc.id;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              student: data,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: data.image != null
                        ? NetworkImage(data.image!)
                        : const AssetImage('assets/add-friend (1).png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Place: ${data.district}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Gender: ${data.gender}",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditPage(
                          id: id,
                          student: data,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    value.deleteStudent(id);
                    value.deleteImage(data.image);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorListItem(
      QueryDocumentSnapshot<StudentModel> doc, StudentProvider value) {
    final data = doc.data();
    final id = doc.id;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              student: data,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: data.image != null
                ? NetworkImage(data.image!)
                : const AssetImage('assets/add-friend (1).png')
                    as ImageProvider,
          ),
          title: Text(
            data.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Place: ${data.district}",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "Gender: ${data.gender}",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditPage(
                        id: id,
                        student: data,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  value.deleteStudent(id);
                  value.deleteImage(data.image);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
