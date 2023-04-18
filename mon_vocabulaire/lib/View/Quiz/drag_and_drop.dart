import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';

import '../../Widgets/Palette.dart';
import '../../Widgets/button.dart';
import '../../Widgets/container_letter.dart';
import '../../Widgets/quiz_app_bar.dart';

import '../../Widgets/Palette.dart';
import '../../Widgets/container_letter.dart';
import '../../Widgets/quiz_app_bar.dart';

class DragAndDrop extends StatefulWidget {
  final User user;
  const DragAndDrop({super.key, required this.user});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  int chances = 3;
  @override
  Widget build(BuildContext context) {

     double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool accepted = false;
    String lettre="";
    Widget _child = ContainerLetter(lettre: "A",isReponse:false);
    return
         Scaffold(

appBar:AppBar(
          backgroundColor: Palette.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: QuizAppBar(chances: chances, user: widget.user,)),
           body: Stack(
               children: [
                //Rectangle d'arriere plan
                 Positioned(
                  top: height*0.2,
                   child: Container(
                    width: width,
                    height: height*0.5,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                   ),
                 ),
            
                //l'image
                Positioned(
                  top: -height*0.5,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset("assets/chat.png",width:150,height: 150,)
                  )
                ),
                    
                // Le Mot
                  Positioned(
                    top: -100,
                    bottom: 0,
                    left: 15,
                    right:0 ,
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         
                         ContainerLetter(lettre: "U",isReponse: false,),
                          SizedBox(width: 5,),
                           ContainerLetter(lettre: "N",isReponse: false,),
                          SizedBox(width: 20,),
                          ContainerLetter(lettre: "C",isReponse: false,),
                          SizedBox(width: 5,),
                          ContainerLetter(lettre: "H",isReponse: false,),
                          SizedBox(width: 5,),
                           DragTarget(
                             onAccept: (data) {
                              // debugPrint('$data');
                              accepted=true;
                              lettre=data.toString();
                            },
                            builder: (context, candidateData, rejectedData) {
                               print(lettre);
                             if(accepted==false){
                              return ContainerLetter(lettre: "...",isReponse: false,);
                              }else if(accepted==true && lettre=="A"){
                                return ContainerLetter(lettre: lettre,isReponse: false,isCorrect: true,);
                              }else{
                                return ContainerLetter(lettre: "...",isReponse: false,);
                              }
                            },
                            
                           ),
                           SizedBox(width: 5,),
                           ContainerLetter(lettre: "T",isReponse: false,)
                      ],
                    ) 
                  ),
         
                //les propositions
                Positioned(
                  top: 150,
                  bottom: 0,
                  left: 20,
                  right:0 ,
         
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Draggable(
                        data: "R",
                        childWhenDragging: Container(
                        ),
                        feedback: Container(
                          child: ContainerLetter(lettre: "R",isReponse: true,)
                        ) ,
                        child: ContainerLetter(lettre: "R",isReponse: false,)
                      ),
                      SizedBox(width: 20,),
                      Draggable(
                      data: "A",
                        childWhenDragging: Container(
                        ),
                      child:  _child,
                      feedback: ContainerLetter(lettre: "A",isReponse:true),
                      // onDragEnd: (details) {
                      //   setState(() {
                      //      _child = Container();
                      //   });
                      // },
                      
                      ),
                       SizedBox(width: 20,),
                       Draggable(
                        data: "U",
                        childWhenDragging: Container(),
                        child: ContainerLetter(lettre: "U",isReponse:false),
                       feedback: ContainerLetter(lettre: "U",isReponse:true),
                      ),
                       SizedBox(width: 20,),
                       Draggable(
                        data: "Z",
                        childWhenDragging: Container(),
                        child:ContainerLetter(lettre: "Z",isReponse:false),
                       feedback: ContainerLetter(lettre: "Z",isReponse: true)
                       ),
                    ],
                  ),
                )   
              ],
                 ),
         );
  }
}
