import 'package:flutter/material.dart';
import 'package:snake/enums/direction_enum.dart';

class ButtonControlWidget extends StatelessWidget {
  final double size;
  final DirectionEnum directionEnum;
  final void Function(DirectionEnum directionEnum) callbackClick;

  const ButtonControlWidget({
    super.key,
    required this.size,
    required this.directionEnum,
    required this.callbackClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Icon(
        _getIcon(),
        size: size / 3,
        color: Colors.black87,
      ),
    );
  }

  IconData _getIcon() {
    switch (directionEnum) {
      case DirectionEnum.up:
        return Icons.arrow_circle_up;
      case DirectionEnum.left:
        return Icons.arrow_circle_left_outlined;
      case DirectionEnum.right:
        return Icons.arrow_circle_right_outlined;
      case DirectionEnum.down:
        return Icons.arrow_circle_down;
    }
  }

  void _onTap() {
    callbackClick.call(directionEnum);
  }
}
