import 'package:card_nft_app/features/auth/widgets/register_form.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: AppTheme.white),
        ),
        backgroundColor: AppTheme.darkCharcoal,
        leading: null,
      ),
      backgroundColor: AppTheme.blurple,
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing * 2,
                    vertical: AppTheme.spacing * 3,
                  ),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.spacing),
                    color: AppTheme.darkCharcoal,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.white,
                            ),
                          )
                        ],
                      ),
                      const RegisterForm()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
