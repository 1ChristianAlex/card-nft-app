import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/features/dashboard/application/deck_application.dart';
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
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DeckState?>(
      converter: (store) => store.state.deck,
      builder: (context, vm) => Text((vm?.id ?? '').toString()),
    );
  }
}
