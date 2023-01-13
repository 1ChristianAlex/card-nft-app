import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/common/widgets/router_auth/route_auth.dart';
import 'package:card_nft_app/features/auth/screens/register_screen.dart';
import 'package:card_nft_app/features/dashboard/dashboard_screen.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
      child: MaterialApp(
        title: 'Card NFT',
        theme: currentTheme,
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/': (context) => const RouterAuth(privateScreen: DashboardScreen()),
        },
      ),
    );
  }
}
