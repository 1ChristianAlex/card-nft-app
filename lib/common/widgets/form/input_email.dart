import 'package:flutter/material.dart';

import '../../text_validation/text_validation.dart';
import 'input_decoration.dart';

class InputEmail extends StatelessWidget {
  final void Function(String? p1)? onSaved;

  const InputEmail({super.key, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: TextInputDecorated.textInput(hintText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        var isEmailValid = TextValidation.isEmail(value);

        if (!isEmailValid) {
          return 'Email is not valid';
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
