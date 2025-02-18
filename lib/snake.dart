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
  final int _pixelPerScreen = 50;
  late double _size;
  bool _isStarted = false;
  bool _screenReady = false;
  DirectionEnum _direction = DirectionEnum.right;
  List<List<Pixel>> _pixelList = [];
  List<Pixel> _snakeList = [];

  Timer? _timer;

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
    _snakeList = [];
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
      Pixel(
        posX: initialIndexX.toDouble() - 1,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 2,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 3,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 4,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 5,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 6,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 7,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 8,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 9,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 10,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
      Pixel(
        posX: initialIndexX.toDouble() - 11,
        posY: initialIndexY.toDouble(),
        typePixelEnum: TypePixelEnum.tail,
      ),
    ]);

    _screenReady = true;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size.width * 0.8;
    if (_isStarted && !_screenReady) {
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
                alternativeBody: _getBodyStart(),
              ),
              const SizedBox(height: 20),
              ControlsWidget(
                size: _size,
                directionNow: _direction,
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

  Widget? _getBodyStart() {
    if (!_isStarted) {
      return Center(
        child: InkWell(
          onTap: () {
            _direction = DirectionEnum.right;
            _isStarted = true;
            _screenReady = false;
            setState(() {});
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black87,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'START',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    } else {
      return null;
    }
  }

  void _update() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 300),
      (Timer timer) {
        _cleanScreen();
        _moveSnake();
        _getCollision();
        _showSnake();
        setState(() {});
      },
    );
    print('UUVVAA');
    print(_timer?.isActive);
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
    Pixel? last;
    for (int i = 0; i < _snakeList.length; i++) {
      Pixel lastTEMP = _snakeList[i];
      if (_snakeList[i].typePixelEnum == TypePixelEnum.head) {
        _snakeList[i] = Pixel(
          posX: _snakeList[i].posX + _getNextPosX(_snakeList[i].posX),
          posY: _snakeList[i].posY + _getNextPosY(_snakeList[i].posY),
          typePixelEnum: _snakeList[i].typePixelEnum,
          directionEnum: _direction,
        );
      } else if (_snakeList[i].typePixelEnum == TypePixelEnum.tail &&
          last != null) {
        _snakeList[i] = Pixel(
          posX: last.posX,
          posY: last.posY,
          typePixelEnum: TypePixelEnum.tail,
          directionEnum: last.directionEnum,
        );
      }
      last = lastTEMP;
    }
  }

  double _getNextPosX(double posX) {
    if (_direction == DirectionEnum.right) {
      if (posX + 1 >= _pixelPerScreen) {
        return -_pixelPerScreen.toDouble();
      } else {
        return 1;
      }
    } else if (_direction == DirectionEnum.left) {
      if (posX - 1 < 0) {
        return (_pixelPerScreen - 1).toDouble();
      } else {
        return -1;
      }
    } else {
      return 0;
    }
  }

  double _getNextPosY(double posY) {
    if (_direction == DirectionEnum.up) {
      if (posY - 1 < 0) {
        return (_pixelPerScreen - 1).toDouble();
      } else {
        return -1;
      }
    } else if (_direction == DirectionEnum.down) {
      if (posY + 1 >= _pixelPerScreen) {
        return -_pixelPerScreen.toDouble();
      } else {
        return 1;
      }
    } else {
      return 0;
    }
  }

  void _getCollision() {
    bool hasCollision = false;
    for (int i = 1; i < _snakeList.length; i++) {
      if (_snakeList[0].posX == _snakeList[i].posX &&
          _snakeList[0].posY == _snakeList[i].posY) {
        hasCollision = true;
        break;
      }
    }

    if (hasCollision) {
      _isStarted = false;
      _timer?.cancel();
    }
  }
}
