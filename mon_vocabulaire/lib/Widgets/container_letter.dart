import 'package:flutter/material.dart';
<<<<<<< HEAD
class ContainerLetter extends StatefulWidget {
 String lettre;
 bool isReponse;
 bool isCorrect;
   ContainerLetter({
    super.key,
    required this.lettre,
    required this.isReponse,
    this.isCorrect=false,
=======
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
>>>>>>> 8e31228ed9acf6cea71837f2bfb52e4830a3b933
  });

  @override
  State<ContainerLetter> createState() => _ContainerLetterState();
}

class _ContainerLetterState extends State<ContainerLetter> {
<<<<<<< HEAD
 

  @override
  Widget build(BuildContext context) {
    if(widget.isReponse){
        return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
        border: Border.all(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Material(child: Text(widget.lettre,style: TextStyle(color: Colors.blueAccent,fontSize: 30),))),
        );
    }else if(!widget.isReponse && widget.isCorrect){
        return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 1,color: Colors.white),
        borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Text(widget.lettre,style: TextStyle(color: Colors.white,fontSize: 30),)),
        );
    }else{
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(6),
      ),
     child: Center(child: Text(widget.lettre,style: TextStyle(color: Colors.blueAccent,fontSize: 30),)),
     );
    }
    
  }
}
=======
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
>>>>>>> 8e31228ed9acf6cea71837f2bfb52e4830a3b933
