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
      ),
      backgroundColor: AppTheme.arsenic,
      body: const SingleChildScrollView(
        child: Center(
          child: Text('Dashboard'),
        ),
      ),
    );
  }
}
