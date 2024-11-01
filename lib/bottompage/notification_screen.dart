import 'package:flutter/material.dart';

class NoficationScreen extends StatefulWidget {
  const NoficationScreen({super.key});

  @override
  State<NoficationScreen> createState() => _NoficationScreenState();
}

class _NoficationScreenState extends State<NoficationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Nofication Screen'),
      ),
    );
  }
}