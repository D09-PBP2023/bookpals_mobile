// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BpScaffold extends StatelessWidget {
  final Widget body;
  final bool safeArea;
  final bool usePadding;
  final bool resizeToAvoidBottomInset;
  const BpScaffold(
      {required this.body,
      this.safeArea = true,
      this.usePadding = true,
      this.resizeToAvoidBottomInset = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    var content = body;
    if (usePadding) {
      content = Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        child: body,
      );
    }
    if (safeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      body: content,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
