import 'package:card_nft_app/common/widgets/form/form_message.dart';
import 'package:flutter/material.dart';
import 'input_decoration.dart';

class InputText extends StatelessWidget {
  final void Function(String? p1)? onSaved;

  final String inputName;

  const InputText({super.key, this.onSaved, required this.inputName});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: TextInputDecorated.textInput(hintText: inputName),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return FormMessage.emailRequired(inputName);
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
