import 'package:flutter/material.dart';
import 'package:snake/enums/direction_enum.dart';
import 'package:snake/widgets/button_control_widget.dart';

class ControlsWidget extends StatelessWidget {
  final double size;
  final void Function(DirectionEnum directionEnum) callbackClick;

  const ControlsWidget({
    super.key,
    required this.size,
    required this.callbackClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonControlWidget(
            size: size,
            directionEnum: DirectionEnum.up,
            callbackClick: callbackClick,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonControlWidget(
                size: size,
                directionEnum: DirectionEnum.left,
                callbackClick: callbackClick,
              ),
              ButtonControlWidget(
                size: size,
                directionEnum: DirectionEnum.right,
                callbackClick: callbackClick,
              ),
            ],
          ),
          ButtonControlWidget(
            size: size,
            directionEnum: DirectionEnum.down,
            callbackClick: callbackClick,
          ),
        ],
      ),
    );
  }
}
