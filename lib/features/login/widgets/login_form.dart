import 'package:card_nft_app/features/login/application/auth_application.dart';
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
        await authAplication()
            .doLogin(email, password)
            .then((value) => {Navigator.pushNamed(context, '/')});
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
      padding: const EdgeInsets.all(AppTheme.spacing * 2),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.spacing),
                  ),
                  contentPadding: inputPadding,
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppTheme.blurple,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  var isEmailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!isEmailValid) {
                    return 'Email is not valid';
                  }

                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.spacing),
                  ),
                  contentPadding: inputPadding,
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppTheme.blurple,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.blurple),
                minimumSize:
                    MaterialStateProperty.all(const Size.fromHeight(50)),
              ),
              onPressed: validateAndLogin,
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
