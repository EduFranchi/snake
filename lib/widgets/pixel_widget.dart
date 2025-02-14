import 'dart:math';

import 'package:flutter/material.dart';

class PixelWidget extends StatelessWidget {
  final double size;
  final int pixelPerScreen;

  const PixelWidget({
    super.key,
    required this.size,
    required this.pixelPerScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size / pixelPerScreen,
      height: size / pixelPerScreen,
      color: Color.fromARGB(
        255,
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      ),
    );
  }
}
