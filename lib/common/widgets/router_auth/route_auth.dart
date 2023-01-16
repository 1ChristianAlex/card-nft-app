import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RouterAuth extends StatefulWidget {
  final Widget privateScreen;

  const RouterAuth(this.privateScreen, {super.key});

  @override
  State<RouterAuth> createState() => _RouterAuthState();
}

class _RouterAuthState extends State<RouterAuth> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> verifyRouteAccess() async {
    var hasAccessResult = await authConnetion.loadUserFromToken().then(
      (value) {
        if (value == false) {
          Navigator.pushNamed(context, RouterPaths.login);
        }

        return value;
      },
    );

    return hasAccessResult;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verifyRouteAccess(),
      builder: (context, snapshot) => StoreConnector<AppState, UserState?>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          if (user != null && snapshot.data == true) {
            return widget.privateScreen;
          } else {
            return const Scaffold(
              backgroundColor: AppTheme.darkCharcoal,
              body: SpinKitDualRing(
                color: AppTheme.blurple,
                size: 50.0,
              ),
            );
          }
        },
      ),
    );
  }
}
