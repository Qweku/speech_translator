// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class NewCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 1.5);
    path.cubicTo(size.width / 4, 2 * (size.height / 2), 3 * (size.width / 4),
        size.height / 1.5, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
