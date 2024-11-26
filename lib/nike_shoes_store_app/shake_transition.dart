import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  const ShakeTransition({
    super.key,
    required this.duration,
    required this.offset,
    this.axis = Axis.horizontal,
    required this.child,
  });

  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: child,
      duration: duration,
      curve: Curves.elasticOut,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child){
        return Transform.translate(
          offset: axis == Axis.horizontal
          ? Offset(value * offset, 0.0)
          : Offset(0.0, value * offset),
          child: child,
        );
      },
    );
  }
}