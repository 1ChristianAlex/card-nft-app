import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/features/dashboard/application/deck_application.dart';
import 'package:card_nft_app/features/dashboard/widgets/button_card_list.dart';
import 'package:card_nft_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DeckDataCards extends StatefulWidget {
  const DeckDataCards({super.key});

  @override
  State<DeckDataCards> createState() => _DeckDataCardsState();
}

class _DeckDataCardsState extends State<DeckDataCards> {
  @override
  void initState() {
    super.initState();

    handleGetDeck();
  }

  Future<void> handleGetDeck() async {
    await deckConnection.getDeckAndDispatch();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(AppTheme.spacing),
        child: StoreConnector<AppState, DeckState?>(
          converter: (store) => store.state.deck,
          builder: (context, deck) => GridView.count(
            crossAxisSpacing: AppTheme.spacing,
            mainAxisSpacing: AppTheme.spacing,
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            shrinkWrap: true,
            children: [
              ButtonCardList(
                label: 'Gambles',
                value: deck == null ? '' : deck.gambles.toString(),
                iconLabel: const Icon(Icons.casino_sharp),
              ),
              ButtonCardList(
                label: 'Coins',
                value: deck == null ? '' : deck.coins.toString(),
                iconLabel: const Icon(
                  Icons.monetization_on,
                  color: AppTheme.green,
                ),
              ),
              ButtonCardList(
                label: 'Claims',
                value: deck == null ? '' : deck.claims.toString(),
                iconLabel: const Icon(
                  Icons.done,
                  color: AppTheme.blurple,
                ),
              ),
              ButtonCardList(
                label: 'Amount',
                value: deck == null ? '' : deck.deckAmount.toString(),
                iconLabel: const Icon(
                  Icons.collections,
                  color: AppTheme.white,
                ),
              ),
            ],
          ),
        ),
      );
}
