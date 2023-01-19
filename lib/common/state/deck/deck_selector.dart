import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../app/app_state.dart';

class DeckSelector {
  static DeckState fromContext(BuildContext context) {
    return StoreProvider.of<AppState>(context).state.deck!;
  }
}
