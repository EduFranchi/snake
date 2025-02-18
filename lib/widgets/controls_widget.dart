import 'package:flutter/material.dart';
import 'package:snake/enums/direction_enum.dart';
import 'package:snake/widgets/button_control_widget.dart';

class ControlsWidget extends StatelessWidget {
  final double size;
  final DirectionEnum directionNow;
  final void Function(DirectionEnum directionEnum) callbackClick;

  const ControlsWidget({
    super.key,
    required this.size,
    required this.directionNow,
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
            directionNow: directionNow,
            directionEnum: DirectionEnum.up,
            callbackClick: callbackClick,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonControlWidget(
                size: size,
                directionNow: directionNow,
                directionEnum: DirectionEnum.left,
                callbackClick: callbackClick,
              ),
              ButtonControlWidget(
                size: size,
                directionNow: directionNow,
                directionEnum: DirectionEnum.right,
                callbackClick: callbackClick,
              ),
            ],
          ),
          ButtonControlWidget(
            size: size,
            directionNow: directionNow,
            directionEnum: DirectionEnum.down,
            callbackClick: callbackClick,
          ),
        ],
      ),
    );
  }
}
