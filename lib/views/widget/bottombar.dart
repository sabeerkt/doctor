import 'package:doctor/views/screens/appoinment.dart';
import 'package:doctor/views/screens/home.dart';
import 'package:doctor/views/screens/prescrption.dart';
import 'package:doctor/views/screens/profile.dart';
import 'package:flutter/material.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedindex = 0;

  void pageChanger(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  List<Widget> pages = [
    HomePage(),
    Appoinment(),
    Prescrption(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color.fromARGB(
            255, 7, 161, 12), // Changed selected item color to green
        unselectedItemColor:
            Colors.lightGreen, // Changed unselected item color to light green
        currentIndex: selectedindex,
        onTap: pageChanger,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.calendar_today), // Changed icon to be more appropriate
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt), // Changed icon to be more appropriate
            label: 'Prescription',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedindex,
        children: pages,
      ),
    );
  }
}
