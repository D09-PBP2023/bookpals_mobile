import 'package:flutter/material.dart';

class TopHomeShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 3 * size.height / 5);
    path.quadraticBezierTo(
        size.width / 2, 4 * size.height / 5 + 50, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BottomHomeShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.reset();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 6, size.height - 75, size.width * 4 / 6, size.height - 75);
    path.quadraticBezierTo(
        size.width - 40, size.height - 80, size.width, size.height - 120);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
