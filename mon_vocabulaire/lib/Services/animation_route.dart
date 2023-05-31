// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SlideRight extends PageRouteBuilder {
  final page;
  SlideRight({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = const Offset(1, 0);
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
  final page;
  SlideButtom({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = const Offset(0, 1);
              var end = const Offset(0, 0);
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

class SlideTop extends PageRouteBuilder {
  final page;
  SlideTop({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              var begin = const Offset(0, -1);
              var end = Offset.zero;
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
  final page;
  SlideCenter({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
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
  final page;
  RotationSlide({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
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
  final page;
  SizedSlide({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              return Align(
                alignment: Alignment.center,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            });
}

class FadeSlide extends PageRouteBuilder {
  final page;
  FadeSlide({this.page})
      : super(
            pageBuilder: (context, animation, animationtwo) => page,
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

  const SlideInFromLeft(
      {super.key, required this.child, required this.animation});

  @override
  _SlideInFromLeftState createState() => _SlideInFromLeftState();
}

class _SlideInFromLeftState extends State<SlideInFromLeft> {
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(widget.animation),
      child: widget.child,
    );
  }
}
