import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class ContainerLetter extends StatefulWidget {
  final String lettre;
  final bool isReponse;
  final bool isCorrect;
  final Color color;
  const ContainerLetter({
    super.key,
    required this.lettre,
    required this.isReponse,
    this.isCorrect = false,
    required this.color,
  });

  @override
  State<ContainerLetter> createState() => _ContainerLetterState();
}

class _ContainerLetterState extends State<ContainerLetter> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 10,
      height: width / 10,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: widget.isReponse
                ? const Color.fromARGB(255, 156, 19, 65)
                : Colors.transparent,
            blurRadius: 0,
            offset: const Offset(0, 8), // Shadow position
          ),
        ],
      ),
      child: Center(
          child: Material(
              color: Colors.transparent,
              child: Text(
                widget.lettre,
                style: TextStyle(
                    color: widget.color == Palette.pink ||
                            widget.color == Palette.lightGreen
                        ? Palette.white
                        : Palette.indigo,
                    fontSize: width / 15),
              ))),
    );
  }
}
