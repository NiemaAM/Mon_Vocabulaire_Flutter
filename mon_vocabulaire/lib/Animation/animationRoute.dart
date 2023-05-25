import 'package:flutter/material.dart';

class SlideRight extends PageRouteBuilder {
  final Page;
  SlideRight({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = Offset(1, 0);
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end);
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            });
}

class SlideButtom extends PageRouteBuilder {
  final Page;
  SlideButtom({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = Offset(0, 1);
              var end = Offset(0, 0);
              var tween = Tween(begin: begin, end: end);
              var curvesanimation = CurvedAnimation(
                  parent: animation, curve: Curves.linearToEaseOut);
              // var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: tween.animate(curvesanimation),
                child: child,
              );
            });
}

class SlideCenter extends PageRouteBuilder {
  final Page;
  SlideCenter({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var curvesanimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);
              // var offsetAnimation = animation.drive(tween);
              return ScaleTransition(
                scale: tween.animate(curvesanimation),
                child: child,
              );
            });
}

class RotationSlide extends PageRouteBuilder {
  final Page;
  RotationSlide({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var curvesanimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);
              // var offsetAnimation = animation.drive(tween);
              return RotationTransition(
                turns: tween.animate(curvesanimation),
                child: child,
              );
            });
}

class SizedSlide extends PageRouteBuilder {
  final Page;
  SizedSlide({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              return Align(
                alignment: Alignment.center,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            });
}

class FadeSlide extends PageRouteBuilder {
  final Page;
  FadeSlide({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              return Align(
                alignment: Alignment.center,
                child: FadeTransition(
                    opacity: animation,
                    child: SizeTransition(sizeFactor: animation, child: child)),
              );
            });
}

class SlideInFromLeft extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;

  SlideInFromLeft({required this.child, required this.animation});

  @override
  _SlideInFromLeftState createState() => _SlideInFromLeftState();
}

class _SlideInFromLeftState extends State<SlideInFromLeft> {
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(widget.animation),
      child: widget.child,
    );
  }
}
