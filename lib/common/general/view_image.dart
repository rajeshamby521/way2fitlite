import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  String image;

  ViewImage({this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: GestureDetector(
            child: PhotoView(
              imageProvider: NetworkImage(image),
            ),
            onLongPress: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  void _closeImage() {}
}
