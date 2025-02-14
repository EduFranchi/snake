import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/enums/direction_enum.dart';
import 'package:snake/enums/type_pixel_enum.dart';
import 'package:snake/pixel.dart';
import 'package:snake/widgets/controls_widget.dart';
import 'package:snake/widgets/screen_widget.dart';

class Snake extends StatefulWidget {
  const Snake({super.key});

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  int _pixelPerScreen = 50;
  late double _size;
  bool _screenReady = false;
  DirectionEnum _direction = DirectionEnum.right;
  List<List<Pixel>> _pixelList = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  void _constructPixelList() {
    List<List<Pixel>> list = [];
    for (int x = 0; x < _pixelPerScreen; x++) {
      List<Pixel> listTemp = [];
      for (int y = 0; y < _pixelPerScreen; y++) {
        listTemp.add(
          Pixel(
            posX: x * (_size / _pixelPerScreen),
            posY: y * (_size / _pixelPerScreen),
            typePixelEnum: TypePixelEnum.clean,
          ),
        );
      }
      list.add(listTemp);
    }
    _pixelList = list;
    _screenReady = true;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size.width * 0.8;
    if (!_screenReady) {
      _constructPixelList();
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScreenWidget(
                size: _size,
                pixelPerScreen: _pixelPerScreen,
                pixelList: _pixelList,
              ),
              const SizedBox(height: 20),
              ControlsWidget(
                size: _size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
