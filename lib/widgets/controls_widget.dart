import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final double size;

  const ControlsWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_circle_up,
            size: size / 3,
            color: Colors.black87,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_circle_left_outlined,
                size: size / 3,
                color: Colors.black87,
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: size / 3,
                color: Colors.black87,
              ),
            ],
          ),
          Icon(
            Icons.arrow_circle_down,
            size: size / 3,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
