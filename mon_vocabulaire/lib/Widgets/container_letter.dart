import 'package:flutter/material.dart';
class ContainerLetter extends StatefulWidget {
 String lettre;
 bool isReponse;
 bool isCorrect;
 Color color;
   ContainerLetter({
    super.key,
    required this.lettre,
    required this.isReponse,
    this.isCorrect=false,
    required this.color
  });

  @override
  State<ContainerLetter> createState() => _ContainerLetterState();
}

class _ContainerLetterState extends State<ContainerLetter> {
 

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
