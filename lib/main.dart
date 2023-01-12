import 'package:card_nft_app/common/widgets/router_auth/route_auth.dart';
import 'package:card_nft_app/features/auth/screens/register_screen.dart';
import 'package:card_nft_app/features/dashboard/dashboard_screen.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'features/auth/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card NFT',
      theme: currentTheme,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/': (context) => const RouterAuth(privateScreen: DashboardScreen()),
      },
    );
  }
}
