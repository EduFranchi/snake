import 'dart:async';

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
  List<Pixel> _snakeList = [];

  late Timer _timer;

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

    int initialIndexX = (_pixelPerScreen / 2).round();
    int initialIndexY = initialIndexX;
    _snakeList.addAll([
      Pixel(
        posX: initialIndexX.toDouble(),
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.head,
        directionEnum: _direction,
      ),
      /*Pixel(
        posX: initialIndexX.toDouble(),
        posY: initialIndexY.toDouble() - 1,
        typePixelEnum: TypePixelEnum.tail,
      ),*/
    ]);

    _screenReady = true;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size.width * 0.8;
    if (!_screenReady) {
      _constructPixelList();
      _update();
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
                callbackClick: (directionEnum) {
                  _direction = directionEnum;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _update() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 300),
      (Timer timer) {
        _cleanScreen();
        _showSnake();
        _moveSnake();
        setState(() {});
      },
    );
  }

  void _cleanScreen() {
    for (int x = 0; x < _pixelList.length; x++) {
      for (int y = 0; y < _pixelList[x].length; y++) {
        _pixelList[x][y] = Pixel(
          posX: _pixelList[x][y].posX,
          posY: _pixelList[x][y].posY,
          typePixelEnum: TypePixelEnum.clean,
          directionEnum: null,
        );
      }
    }
  }

  void _showSnake() {
    for (int x = 0; x < _pixelList.length; x++) {
      for (int y = 0; y < _pixelList[x].length; y++) {
        for (Pixel snake in _snakeList) {
          if (x == snake.posX && y == snake.posY) {
            _pixelList[x][y] = Pixel(
              posX: _pixelList[x][y].posX,
              posY: _pixelList[x][y].posY,
              typePixelEnum: snake.typePixelEnum,
              directionEnum: snake.directionEnum,
            );
          }
        }
      }
    }
  }

  void _moveSnake() {
    for (int i = 0; i < _snakeList.length; i++) {
      _snakeList[i] = Pixel(
        posX: _snakeList[i].posX + _getNextPosX(),
        posY: _snakeList[i].posY + _getNextPosY(),
        typePixelEnum: _snakeList[i].typePixelEnum,
        directionEnum: _direction,
      );
    }
  }

  double _getNextPosX() {
    if (_direction == DirectionEnum.right) {
      return 1;
    } else if (_direction == DirectionEnum.left) {
      return -1;
    } else {
      return 0;
    }
  }

  double _getNextPosY() {
    if (_direction == DirectionEnum.up) {
      return -1;
    } else if (_direction == DirectionEnum.down) {
      return 1;
    } else {
      return 0;
    }
  }
}
