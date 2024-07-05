import 'package:flutter/material.dart';

class Prescrption extends StatefulWidget {
  const Prescrption({super.key});

  @override
  State<Prescrption> createState() => _PrescrptionState();
}

class _PrescrptionState extends State<Prescrption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Prescription'),
      ),
      body: const Center(
        child: Text('Prescription'),
      ),
    );
  }
}
