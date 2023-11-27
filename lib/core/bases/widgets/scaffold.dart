// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BpScaffold extends StatelessWidget {
  final Widget body;
  final Widget? navigationBar;
  final bool safeArea;
  final bool usePadding;
  final bool resizeToAvoidBottomInset;
  const BpScaffold(
      {required this.body,
      this.safeArea = true,
      this.usePadding = true,
      this.resizeToAvoidBottomInset = false,
      this.navigationBar,
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
      content = SafeArea(bottom: false, child: content);
    }

    return Scaffold(
      extendBody: true,
      body: content,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: navigationBar,
    );
  }
}
