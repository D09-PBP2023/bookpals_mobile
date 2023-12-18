// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BpScaffold extends StatelessWidget {
  final Widget body;
  final Widget? navigationBar;
  final bool safeArea;
  final EdgeInsetsGeometry? padding;
  final bool resizeToAvoidBottomInset;
  final Color backgroundColor;
  final PreferredSizeWidget? appBar;
  const BpScaffold(
      {required this.body,
      this.safeArea = true,
      this.resizeToAvoidBottomInset = false,
      this.backgroundColor = const Color(0xFFF8F8F8),
      this.padding,
      this.navigationBar,
      this.appBar,
      super.key});

  @override
  Widget build(BuildContext context) {
    var content = body;
    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: body,
      );
    }
    if (safeArea) {
      content = SafeArea(bottom: false, child: content);
    }

    return Scaffold(
      appBar: appBar,
      body: content,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: navigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
