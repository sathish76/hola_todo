import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCircularRevealPage extends CustomTransitionPage {
  final Offset position;

  CustomCircularRevealPage({
    required super.key,
    required super.child,
    required this.position,
  }) : super(
         transitionDuration: Duration(milliseconds: 300),
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return CircularRevealTransition(
             animation: animation,
             position: position,
             child: child,
           );
         },
       );
}

class CircularRevealTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final Offset position;

  const CircularRevealTransition({
    super.key,
    required this.animation,
    required this.child,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CircularRevealClipper(animation.value, position),
          child: child,
        );
      },
      child: child,
    );
  }
}

class CircularRevealClipper extends CustomClipper<Path> {
  final double progress;
  final Offset center;

  CircularRevealClipper(this.progress, this.center);

  @override
  Path getClip(Size size) {
    double radius =
        progress * sqrt(size.width * size.width + size.height * size.height);
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) =>
      progress != oldClipper.progress;
}
