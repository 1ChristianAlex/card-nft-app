import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final void Function()? onPressed;

  final String label;

  const FormButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppTheme.blurple),
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: AppTheme.white),
      ),
    );
  }
}
