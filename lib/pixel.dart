import 'package:snake/enums/direction_enum.dart';
import 'package:snake/enums/type_pixel_enum.dart';

class Pixel {
  final double posX;
  final double posY;
  final TypePixelEnum typePixelEnum;
  final DirectionEnum? directionEnum;

  Pixel({
    required this.posX,
    required this.posY,
    required this.typePixelEnum,
    this.directionEnum,
  });
}
