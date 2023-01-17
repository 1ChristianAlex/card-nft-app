import 'package:card_nft_app/common/widgets/form/form_message.dart';
import 'package:card_nft_app/common/widgets/form/input_decoration.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatelessWidget {
  final void Function(String? p1)? onSaved;

  const InputPassword({super.key, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: TextInputDecorated.textInput(hintText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return FormMessage.emailRequired('Password');
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
