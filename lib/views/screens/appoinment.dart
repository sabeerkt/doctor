import 'package:flutter/material.dart';

class Appoinment extends StatefulWidget {
  const Appoinment({super.key});

  @override
  State<Appoinment> createState() => _AppoinmentState();
}

class _AppoinmentState extends State<Appoinment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Appoinment'),
      ),
      body: const Center(
        child: Text('Appoinment'),
      ),
    );
  }
}