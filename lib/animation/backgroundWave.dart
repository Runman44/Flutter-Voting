import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mranderson_voting/animation/wave.dart';

class FancyBackgroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
      ],
    );
  }

  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}