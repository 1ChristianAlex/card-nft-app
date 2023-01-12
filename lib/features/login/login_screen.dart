import 'package:card_nft_app/features/login/apresentation/login_form.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blurple,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.spacing),
            color: AppTheme.softBlack,
          ),
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing),
                child: Column(children: [
                  Text(
                    'Welcome',
                    style:
                        GoogleFonts.rubik(color: Colors.white70, fontSize: 24),
                  )
                ]),
              ),
              const LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
