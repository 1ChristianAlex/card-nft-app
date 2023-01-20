import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/common/widgets/router_auth/route_auth.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/auth/screens/register_screen.dart';
import 'package:card_nft_app/features/dashboard/dashboard_screen.dart';
import 'package:card_nft_app/features/gamble/gamble_screen.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:redux/redux.dart';

import 'features/auth/screens/login_screen.dart';

void main() async {
  runApp(MyApp(
    store: appStore,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitRing(
            color: AppTheme.green,
            size: 50.0,
          ),
        ),
        child: MaterialApp(
          title: 'Card NFT',
          theme: currentTheme,
          routes: {
            RouterPaths.login: (context) => const LoginScreen(),
            RouterPaths.register: (context) => const RegisterScreen(),
            RouterPaths.home: (context) => const RouterAuth(DashboardScreen()),
            RouterPaths.gamble: (context) => const RouterAuth(GambleScreen()),
          },
        ),
      ),
    );
  }
}
