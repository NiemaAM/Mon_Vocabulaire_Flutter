import 'package:flutter/material.dart';

import '../Widgets/Triangle.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  const BubbleMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(
                  bottom: 5,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                    bottomLeft: Radius.circular(19),
                    bottomRight: Radius.circular(19),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 8.0),
                    )
                  ],
                ),
                child: Text(
                  message,
                  style:
                      const TextStyle(color: Color(0xFF0E57AC), fontSize: 15),
                ),
              ),
            ),
            CustomPaint(painter: Triangle(Colors.white)),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
              ),
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    // ignore: unnecessary_string_interpolations
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
