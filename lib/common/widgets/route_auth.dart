import 'package:card_nft_app/common/jwt_manager/jwt_manager.dart';
import 'package:card_nft_app/features/login/login_screen.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RouterAuth extends StatelessWidget {
  final Widget privateScreen;

  const RouterAuth({super.key, required this.privateScreen});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: JWTManager().isAuth(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: AppTheme.arsenic,
            body: Center(
              child: SpinKitRing(
                color: AppTheme.green,
                size: 50.0,
              ),
            ),
          );
        }
        if (snapshot.data == true) {
          return privateScreen;
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
