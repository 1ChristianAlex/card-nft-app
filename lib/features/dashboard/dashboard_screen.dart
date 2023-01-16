import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/features/dashboard/widgets/deck_data_cards.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.darkCharcoal,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          authConnetion.logout();

          Navigator.pushNamed(context, RouterPaths.login);
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.logout_outlined),
      ),
      backgroundColor: AppTheme.arsenic,
      body: const DeckDataCards(),
    );
  }
}
