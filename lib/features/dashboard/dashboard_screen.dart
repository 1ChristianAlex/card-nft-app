import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';
import 'package:card_nft_app/features/auth/application/auth_application.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.darkCharcoal,
        leading: null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          authConnetion.logout();
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.logout_outlined),
      ),
      backgroundColor: AppTheme.arsenic,
      body: SingleChildScrollView(
        child: StoreConnector<AppState, UserState?>(
          converter: (store) => store.state.user,
          builder: (context, user) {
            var name = user!.name;
            return (Text('Welcome $name'));
          },
        ),
      ),
    );
  }
}
