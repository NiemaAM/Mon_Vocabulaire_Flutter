
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

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
bool variswin=false;

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
                                      player=="assets/images/127.png" ? "Très bonne mission !" : "Ça y est, essaie encore.",
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
                                    player=="assets/images/127.png" ? "Félicitations, tu as fait du bon travail!" : "Ressayer !!",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Image.asset(
                                  player=="assets/images/127.png" ? "assets/mascotte/win.gif" : "assets/mascotte/lose.gif",
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
    return 
//     Container(
//       constraints: BoxConstraints.expand(),
//       decoration : BoxDecoration(
//         image: DecorationImage(image: AssetImage("assets/back3.jpg"),
//        // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.modulate,),
//         fit: BoxFit.cover,
// )
    // child:  ),
      Scaffold(
     backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Palette.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Palette.black),
          title: Row(
            children: [
              Image.asset(
                "assets/images/games/tic-tac-toe.png",
                width: 40,
              ),
              const Text(
                " Tic-Tac-Toe",
                style: TextStyle(color: Palette.black),
              ),
            ],
          ),
        ),
        body:
        Column(children: [
    
         Center(
           child: Container(
            color: Color.fromARGB(84, 3, 168, 244),
            width: boardwidth,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Row(children: [
                Image.asset("assets/images/avatars/avatar_girl.png",width: 80,height: 80,),
                Image.asset("assets/lettre-x.png",width: 50,height: 50,),
                  ],)),

                SizedBox(width: boardwidth/21,),
                Text("0",style: TextStyle(fontSize: 30,color: Colors.black),),
                SizedBox(width: boardwidth/9,),
                Text("0",style: TextStyle(fontSize: 30,color: Colors.black),),
                SizedBox(width: boardwidth/21,),
                
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Row(children: [
                    Image.asset("assets/images/logo.png",width: 80,height: 80,),
                    Image.asset("assets/lettre-o.png",width: 50,height: 50,)
                  ],)),

               ],
            ),
           )
         ),
          SizedBox(height: 15,),
          Center(
            child: SizedBox.square(  dimension: boardwidth/1.2,
                   // width: boardwidth*2.1,
                   // height: boardheight*0.2,
            child: GridView.count(crossAxisCount: Game.boardlenth ~/ 3,
            padding: const EdgeInsets.all(20.0),
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
             children: 
              List.generate(Game.boardlenth, (index){
                return
                 InkWell(
                  onTap: gameover ?null:(){
                    setState(() {
                      if(game.board![index]==""){
                      game.board![index] = "assets/lettre-x.png";
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
                      game.board![randomNumber]="assets/lettre-o.png";
                      
                      }
                      if(game.board![0] == game.board![1] && game.board![1] == game.board![2] && game.board![0]!=""){
                       // variswin=true;
                        // Future.delayed(Duration(seconds: 2), ()=>
                         iswin(game.board![0]);
                       //  );
                      }else if(game.board![0] == game.board![3] && game.board![3] == game.board![6] && game.board![0]!=""){
                       // variswin=true;
                         iswin(game.board![0]);
                      }else if(game.board![0] == game.board![4] && game.board![4] == game.board![8] && game.board![0]!=""){
                         //variswin=true;
                         iswin(game.board![0]);
                      }else if(game.board![3] == game.board![4] && game.board![4] == game.board![5] && game.board![3]!=""){
                       //   variswin=true;
                         iswin(game.board![3]);
                      }else if(game.board![6] == game.board![7] && game.board![7] == game.board![8] && game.board![6]!=""){
                        //  variswin=true;
                         iswin(game.board![6]);
                      }else if( game.board![1] == game.board![4] && game.board![4] == game.board![7] && game.board![1]!=""){
                        // variswin=true;
                         iswin(game.board![1]);
                      }else if(game.board![2] == game.board![5] && game.board![5] == game.board![8] && game.board![2]!=""){
                       //   variswin=true;
                         iswin(game.board![2]);
                      }else if(game.board![2] == game.board![4] && game.board![4] == game.board![6] && game.board![2]!=""){
                       //  variswin=true;
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
                          color: Colors.transparent,
                          border: index == 0
                              ? const Border(
                                  top: BorderSide(
                                      color: Colors.transparent, width: 3),
                                  left: BorderSide(
                                      color: Colors.transparent, width: 3),
                                  right: BorderSide(
                                      color: Colors.black, width: 3),
                                  bottom: BorderSide(
                                      color: Colors.black, width: 3),
                                )
                              : index == 1
                                  ? const Border(
                                      top: BorderSide(
                                          color: Colors.transparent, width: 3),
                                      left: BorderSide(
                                          color: Colors.black, width: 3),
                                      right: BorderSide(
                                          color: Colors.black, width: 3),
                                      bottom: BorderSide(
                                          color: Colors.black, width: 3),
                                    )
                                  : index == 2
                                      ? const Border(
                                          top: BorderSide(
                                              color: Colors.transparent,
                                              width: 3),
                                          left: BorderSide(
                                              color: Colors.black, width: 3),
                                          right: BorderSide(
                                              color: Colors.transparent,
                                              width: 3),
                                          bottom: BorderSide(
                                              color: Colors.black, width: 3),
                                        )
                                      : index == 3
                                          ? const Border(
                                              top: BorderSide(
                                                  color: Colors.black,
                                                  width: 3),
                                              left: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 3),
                                              right: BorderSide(
                                                  color: Colors.black,
                                                  width: 3),
                                              bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 3),
                                            )
                                          : index == 5
                                              ? const Border(
                                                  top: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  left: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  right: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 3),
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                )
                                              : index == 6
                                                  ? const Border(
                                                      top: BorderSide(
                                                          color: Colors.black,
                                                          width: 3),
                                                      left: BorderSide(
                                                          color:
                                                              Colors.transparent,
                                                          width: 3),
                                                      right: BorderSide(
                                                          color: Colors.black,
                                                          width: 3),
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.transparent,
                                                          width: 3),
                                                    )
                                                  : index == 7
                                                      ? const Border(
                                                          top: BorderSide(
                                                              color: Colors.black,
                                                              width: 3),
                                                          left: BorderSide(
                                                              color: Colors.black,
                                                              width: 3),
                                                          right: BorderSide(
                                                              color: Colors.black,
                                                              width: 3),
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 3),
                                                        )
                                                      : index == 8
                                                          ? const Border(
                                                              top: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 3),
                                                              left: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 3),
                                                              right: BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 3),
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 3),
                                                            )
                                                          : const Border(
                                                              top: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 3),
                                                              left: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 3),
                                                              right: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 3),
                                                              bottom: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 3),
                                                            ),
                        ),
                    child: Center(
                      child:
                       game.board![index].isEmpty ? Text("")
                       : Image.asset(game.board![index],width: 100,height: 100,),
                    ),
                    ),
                 );
              })
            ,),
                  ),
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