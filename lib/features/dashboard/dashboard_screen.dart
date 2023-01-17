import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/constants.dart';
import 'package:card_nft_app/features/dashboard/widgets/deck_data_cards.dart';
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
        automaticallyImplyLeading: false,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     authConnetion.logout();

      //     Navigator.pushNamed(context, RouterPaths.login);
      //   },
      //   backgroundColor: Colors.pink,
      //   child: const Icon(Icons.logout_outlined),
      // ),
      backgroundColor: AppTheme.arsenic,
      body: const DeckDataCards(),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: AppTheme.arsenic,
        elevation: 20.0,
        child: Container(height: 50.0),
      ),
      floatingActionButton: StoreConnector<AppState, DeckState?>(
        converter: (store) => store.state.deck,
        builder: (context, deck) => FloatingActionButton(
          backgroundColor: AppTheme.blurple,
          onPressed: (deck != null && deck.gambles > 0)
              ? () {
                  Navigator.pushNamed(context, RouterPaths.gamble);
                }
              : null,
          elevation: 5,
          child: const Icon(Icons.casino_sharp),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
