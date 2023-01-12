import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card NFT',
      theme: currentTheme,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {'/': (context) => const LoginScreen()},
    );
  }
}
