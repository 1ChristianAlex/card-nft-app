import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RouterAuth extends StatefulWidget {
  final Widget privateScreen;

  const RouterAuth({super.key, required this.privateScreen});

  @override
  State<RouterAuth> createState() => _RouterAuthState();
}

class _RouterAuthState extends State<RouterAuth> {
  @override
  void initState() {
    super.initState();
    authConnetion.loadUserFromToken();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState?>(
      converter: (store) => store.state.user,
      builder: (context, user) {
        if (user != null) {
          return widget.privateScreen;
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
