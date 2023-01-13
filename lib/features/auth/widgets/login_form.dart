import 'package:card_nft_app/common/widgets/form/form_button.dart';
import 'package:card_nft_app/common/widgets/form/input_email.dart';
import 'package:card_nft_app/common/widgets/form/input_password.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  final inputPadding = const EdgeInsets.symmetric(
    horizontal: AppTheme.spacing,
    vertical: AppTheme.spacing * 2,
  );

  Future<void> validateAndLogin() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      _formKey.currentState?.save();

      try {
        context.loaderOverlay.show();
        FocusManager.instance.primaryFocus?.unfocus();
        await authConnetion
            .doLogin(email, password)
            .then((value) => {Navigator.pushNamed(context, RouterPaths.home)});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        context.loaderOverlay.hide();
      }
    }
  }

  void navigateRegisterScreen() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing * 2),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing),
              child: InputEmail(onSaved: (value) {
                email = value!;
              }),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing),
              child: InputPassword(onSaved: (value) {
                password = value!;
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing),
              child: FormButton(onPressed: validateAndLogin, label: 'Login'),
            ),
            FormButton(onPressed: navigateRegisterScreen, label: 'Register')
          ],
        ),
      ),
    );
  }
}
