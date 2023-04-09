import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.2805714);
    path0.quadraticBezierTo(size.width * 0.4910833, size.height * -0.0766429,
        size.width, size.height * 0.2820000);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(size.width * -0.0085417, size.height * 0.8698571, 0,
        size.height * 0.2805714);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
