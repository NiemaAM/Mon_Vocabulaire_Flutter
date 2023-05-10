
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../Widgets/Palette.dart';

class tic_tac extends StatefulWidget{

 const tic_tac({super.key});
 
 @override
  State<StatefulWidget> createState() => tic_tac_state();
  
}

class tic_tac_state extends State<tic_tac>{

Game game = Game();
bool gameover = false;
int randomNumber =0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board= Game.initGameBoard();
    print(game.board);
    
  }

  void voidgame(){

                      AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Resultat',
                        desc: 'égalité',
                        btnCancelIcon: Icons.home,
                        btnCancelText: " ",
                        btnCancelOnPress: () {
                        Navigator.pop(context);
                        },
                        btnOkIcon: Icons.restart_alt_rounded,
                        btnOkText: " ",
                        btnOkOnPress: () {
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const tic_tac(),
                        )
                        );}
                      ).show();

  }

    void iswin(String player){
                          AwesomeDialog(
                              context: context,
                              headerAnimationLoop: false,
                              customHeader: Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color:  Palette.yellow,
                                    borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: const Icon(
                                  Icons.star_rounded,
                                  color: Palette.white,
                                  size: 80,
                                ),
                              ),
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              body: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      player=="X" ? "Très bonne mission !" : "Ça y est, essaie encore.",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Palette.pink,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    player=="X" ? "Félicitations, tu as fait du bon travail!" : "Ressayer !!",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Image.asset(
                                  player=="X" ? "assets/mascotte/win.gif" : "assets/mascotte/lose.gif",
                                  scale: 4,
                                ),
                              ]),
                              btnCancelIcon: Icons.home,
                              btnCancelText: " ",
                              btnCancelOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkIcon: Icons.restart_alt_rounded,
                              btnOkText: " ",
                              btnOkOnPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const tic_tac(),
                                )
                                );
                              },
                          ).show(); 
                  }
  
 @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    double boardheight = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: 
      Column(children: [
        
        const SizedBox(height: 30,),
        Container(
          width: boardwidth*0.6,
          height: 60,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 244, 239, 239),
            border: Border.all(
              width: 2,
              color: Colors.lightBlue
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SALMA     ",style: TextStyle(color: Colors.pinkAccent,fontSize: 18, fontWeight: FontWeight.bold),),
              Container(child: const Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3371/3371822.png'),),
              decoration: BoxDecoration(border: Border.all(color: Colors.lightBlue), borderRadius:BorderRadius.circular(50))
              ),         
              const Text("        X ",style: TextStyle(color: Colors.pinkAccent,fontSize: 18, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const SizedBox(height: 50,),
        Container(  
        width: boardwidth,
        height: boardheight*0.8,
        child: GridView.count(crossAxisCount: Game.boardlenth ~/ 3,
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
         children: 
          List.generate(Game.boardlenth, (index){
            return
             InkWell(
              onTap: gameover ?null:(){
                setState(() {
                  if(game.board![index]==""){
                  game.board![index] = "X";
                   Random random = new Random();
                  List<int> casenum=[];
                  for(int j=0; j<9;j++){
                    if(game.board![j] == ""){
                     casenum.add(j);
                    }
                  }
                  int randomIndex = random.nextInt(casenum.length);
                  randomNumber = casenum[randomIndex];
                  print(randomNumber);
                  game.board![randomNumber]="O";
                  }
                  if(game.board![0] == game.board![1] && game.board![1] == game.board![2] && game.board![0]!=""){
                     iswin(game.board![0]);
                  }else if(game.board![0] == game.board![3] && game.board![3] == game.board![6] && game.board![0]!=""){
                     iswin(game.board![0]);
                  }else if(game.board![0] == game.board![4] && game.board![4] == game.board![8] && game.board![0]!=""){
                     iswin(game.board![0]);
                  }else if(game.board![3] == game.board![4] && game.board![4] == game.board![5] && game.board![3]!=""){
                     iswin(game.board![3]);
                  }else if(game.board![6] == game.board![7] && game.board![7] == game.board![8] && game.board![6]!=""){
                     iswin(game.board![6]);
                  }else if( game.board![1] == game.board![4] && game.board![4] == game.board![7] && game.board![1]!=""){
                     iswin(game.board![1]);
                  }else if(game.board![2] == game.board![5] && game.board![5] == game.board![8] && game.board![2]!=""){
                     iswin(game.board![2]);
                  }else if(game.board![2] == game.board![4] && game.board![4] == game.board![6] && game.board![2]!=""){
                     iswin(game.board![2]);
                  }else{
                    int count=0;
                    for(int i=0;i<9;i++){
                      if(game.board![i]!=""){
                          count++;
                      }
                    }
                    if(count == 9){
                      voidgame();
                    }
                  }

                });
              },
               child: Container(
                width: Game.blocsize,
                height: Game.blocsize,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 12, 12, 12),
                  borderRadius: BorderRadius.circular(16.0),
                 // border: Border.all(color: Colors.black),
                  boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 3,
                    spreadRadius: 0.4,
                    offset: Offset(2.0, 1),
                  )
                  ],
                ),
                child: Center(
                  child: GlowText(game.board![index], style:
                   TextStyle(color: game.board![index] == "X" 
                   ?Colors.lightBlue
                   : Colors.pinkAccent,
                   fontSize: 64.0,
                   ),),
                ),
                ),
             );
          })
        ,),
      ), 
      ],)
     
     );}
}

class player{

  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {

  static final boardlenth = 9;
  static final blocsize =100.0;

  List<String>? board;
  static List<String>? initGameBoard() => List.generate(boardlenth, (index) => player.empty);
}