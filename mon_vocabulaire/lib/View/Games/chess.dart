import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({super.key});

  @override
  State<ChessGame> createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chess"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ChessBoard(
            controller: ChessBoardController(),
            onMove: () {},
            size: MediaQuery.of(context).size.width,
            enableUserMoves: true,
            boardColor: BoardColor.orange,
          )
        ],
      )),
    );
  }
}
