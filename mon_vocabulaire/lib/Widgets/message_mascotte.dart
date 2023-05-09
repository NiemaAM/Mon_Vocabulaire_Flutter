import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/Triangle.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  const BubbleMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: width > 500 ? 150 : width / 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(130, 255, 255, 255),
                    blurRadius: 30.0,
                    spreadRadius: 10.0,
                    offset: Offset(0.0, 0),
                  )
                ],
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
