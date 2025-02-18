import 'package:flutter/material.dart';
import 'package:snake/pixel.dart';
import 'package:snake/widgets/pixel_widget.dart';

class ScreenWidget extends StatelessWidget {
  final double size;
  final int pixelPerScreen;
  final List<List<Pixel>> pixelList;
  final Widget? alternativeBody;

  const ScreenWidget({
    super.key,
    required this.size,
    required this.pixelPerScreen,
    required this.pixelList,
    this.alternativeBody,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 10,
      height: size + 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black87,
          width: 5,
        ),
      ),
      child: _getBody(),
    );
  }

  Widget _getBody() {
    if (alternativeBody != null) {
      return alternativeBody!;
    } else {
      return Stack(
        children: _writePixelList(),
      );
    }
  }

  List<Widget> _writePixelList() {
    List<Widget> list = [];
    for (List<Pixel> pixelListTEMP in pixelList) {
      for (Pixel pixel in pixelListTEMP) {
        list.add(
          Padding(
            padding: EdgeInsets.only(
              left: pixel.posX,
              top: pixel.posY,
            ),
            child: PixelWidget(
              size: size,
              pixelPerScreen: pixelPerScreen,
              pixel: pixel,
            ),
          ),
        );
      }
    }
    return list;
  }
}
