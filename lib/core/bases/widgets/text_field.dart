import 'package:flutter/material.dart';

import '../../theme/color_theme.dart';

class BookpalsTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onComplete;
  final bool infiniteLines;
  final bool isObscure;

  const BookpalsTextField(
      {required this.title,
      required this.hint,
      required this.controller,
      this.onChanged,
      this.onComplete,
      this.infiniteLines = false,
      this.isObscure = false,
      super.key});

  @override
  State<BookpalsTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<BookpalsTextField> {
  bool _isSelected = false;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: _isSelected
                  ? ColorTheme.accentSwatch
                  : ColorTheme.primarySwatch,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: FocusScope(
                    onFocusChange: (isFocused) {
                      setState(() {
                        _isSelected = isFocused;
                      });
                    },
                    child: TextField(
                      cursorColor: ColorTheme.black,
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      style: const TextStyle(
                        color: ColorTheme.black,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: ColorTheme.black),
                        hintText: widget.hint,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                        suffixIcon: widget.isObscure
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                                color: Colors.black,
                                icon: Icon(_isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )
                            : null,
                      ),
                      maxLines: widget.infiniteLines ? null : 1,
                      onEditingComplete: widget.onComplete,
                      obscureText: widget.isObscure && _isHidden,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
