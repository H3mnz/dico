import 'package:flutter/material.dart';

class OvalClipper extends CustomClipper<Path> {
  final bool flip;

  OvalClipper([this.flip = false]);
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    Path path = Path();
    double x = 16;

    if (flip) {
      path.lineTo(0, 0);
      path.lineTo(0, x);
      path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
      path.quadraticBezierTo(size.width - size.width / 4, 0, size.width, x);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      return path;
    }

    path.lineTo(0, height - x);
    path.quadraticBezierTo(width / 2, height + x, width, height - x);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}

class OvalClipper2 extends CustomClipper<Path> {
  final bool flip;

  OvalClipper2([this.flip = false]);
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    Path path = Path();
    double x = 16;

    if (flip) {
      path.lineTo(0, 0);
      path.lineTo(0, x);
      path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
      path.quadraticBezierTo(size.width - size.width / 4, 0, size.width, x);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      return path;
    }

    path.lineTo(0, height);
    path.quadraticBezierTo(width / 2, height, width, height);
    path.lineTo(width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
