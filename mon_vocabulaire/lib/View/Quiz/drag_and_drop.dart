import 'package:flutter/material.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({super.key});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("data"),
    );
  }
}
