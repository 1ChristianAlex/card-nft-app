import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class TextInputDecorated {
  static InputDecoration textInput({String? hintText}) => InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.spacing),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing,
          vertical: AppTheme.spacing * 2,
        ),
        fillColor: Colors.white,
        filled: true,
        focusColor: AppTheme.blurple,
      );
}
