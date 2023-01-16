import 'package:card_nft_app/common/application_data/application_state.dart';
import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/state/deck/deck_actions.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/features/dashboard/data/deck_repo.dart';

class DeckAplication extends ApplicationState {
  late DeckRepositorie repo;

  DeckAplication({required super.store, required super.adapter}) {
    repo = DeckRepositorie(adapter);
  }

  Future<void> getDeckAndDispatch() async {
    var deck = await repo.getUserDeck();

    store.dispatch(
      updateDeck(deck),
    );
  }
}

DeckAplication get deckConnection {
  return DeckAplication(
    adapter: HttpAdapter(loadBearer: true),
    store: appStore,
  );
}
