import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/triangle.dart';
import 'package:animator/animator.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  const BubbleMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: width > 500 ? 150 : width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Container(
              width: width - 100,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                bottom: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(19)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(134, 80, 80, 80),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 6.0),
                  )
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(color: Color(0xFF0E57AC), fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CustomPaint(painter: Triangle(Colors.white)),
          ),
          Container(
            width: 100,
            height: 100,
            child: Animator<double>(
                tween: Tween<double>(begin: 50, end: 100),
                duration: Duration(seconds: 2),
                cycles: 0,
                builder: (context, AnimatorState, child) => Center(
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: AnimatorState.value,
                          width: AnimatorState.value,
                          child: const Image(
                            image: AssetImage("assets/logo.png"),
                          )),
                    )),
          ),
        ],
      ),
    );
  }
}
