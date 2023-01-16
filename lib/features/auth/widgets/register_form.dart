import 'package:card_nft_app/common/widgets/form/form_button.dart';
import 'package:card_nft_app/common/widgets/form/input_email.dart';
import 'package:card_nft_app/common/widgets/form/input_password.dart';
import 'package:card_nft_app/common/widgets/form/input_text.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/features/auth/application/auth_view_model.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final formInputPadding = const EdgeInsets.only(bottom: AppTheme.spacing);

  late String name;
  late String lastName;
  late String email;
  late String password;

  void onRegisterClick() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      _formKey.currentState?.save();

      try {
        context.loaderOverlay.show();
        FocusManager.instance.primaryFocus?.unfocus();

        await authConnetion.register(NewUserModel(
          name: name,
          lastName: lastName,
          email: email,
          password: password,
        ));

        await authConnetion.doLogin(email, password).then((value) =>
            {Navigator.pushReplacementNamed(context, RouterPaths.home)});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        context.loaderOverlay.hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppTheme.spacing * 2),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: formInputPadding,
              child: InputText(
                inputName: 'Name',
                onSaved: (p1) {
                  name = p1!;
                },
              ),
            ),
            Padding(
              padding: formInputPadding,
              child: InputText(
                inputName: 'Lastname',
                onSaved: (p1) {
                  lastName = p1!;
                },
              ),
            ),
            Padding(
              padding: formInputPadding,
              child: InputEmail(
                onSaved: (p1) {
                  email = p1!;
                },
              ),
            ),
            Padding(
              padding: formInputPadding,
              child: InputPassword(
                onSaved: (p1) {
                  password = p1!;
                },
              ),
            ),
            Padding(
              padding: formInputPadding,
              child: FormButton(onPressed: onRegisterClick, label: 'Register'),
            ),
          ],
        ),
      ),
    );
  }
}
