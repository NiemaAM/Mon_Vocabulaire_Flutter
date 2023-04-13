import 'package:flutter/material.dart';

import '../../Widgets/Palette.dart';

class NinjaBubble extends StatefulWidget {
  const NinjaBubble({super.key});

  @override
  State<NinjaBubble> createState() => _NinjaBubbleState();
}

class _NinjaBubbleState extends State<NinjaBubble> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        elevation: 1,
        title: const Text("Ninja Bubble"),
      ),
      body: const Center(
        child: Text("Ninja Bubble"),
      ),
    );
  }
}
