import 'package:card_nft_app/common/widgets/appBar/app_scaffold.dart';
import 'package:card_nft_app/features/dashboard/widgets/deck_data_cards.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.darkCharcoal,
        automaticallyImplyLeading: false,
      ),
      body: const DeckDataCards(),
    );
  }
}
