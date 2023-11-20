import 'package:flutter/material.dart';

class TopHomeShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 3*size.height/5);
    path.quadraticBezierTo(size.width / 2, 4*size.height/5 + 50, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}