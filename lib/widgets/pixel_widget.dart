import 'package:flutter/material.dart';
import 'package:snake/enums/type_pixel_enum.dart';
import 'package:snake/pixel.dart';

class PixelWidget extends StatelessWidget {
  final double size;
  final int pixelPerScreen;
  final Pixel pixel;

  const PixelWidget({
    super.key,
    required this.size,
    required this.pixelPerScreen,
    required this.pixel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size / pixelPerScreen,
      height: size / pixelPerScreen,
      color: _getColorPixel(),
    );
  }

  Color _getColorPixel() {
    if (pixel.typePixelEnum == TypePixelEnum.head) {
      return Colors.deepPurple;
    } else if (pixel.typePixelEnum == TypePixelEnum.tail) {
      return Colors.deepPurpleAccent;
    } else if (pixel.typePixelEnum == TypePixelEnum.point) {
      return Colors.deepOrange;
    } else {
      return Colors.transparent;
    }
  }
}
