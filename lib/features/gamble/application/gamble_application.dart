import 'package:card_nft_app/common/application_data/application_state.dart';
import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/features/card/application/card_model.dart';
import 'package:card_nft_app/features/gamble/data/gamble_repo.dart';

class GambleApplication extends ApplicationState {
  late GambleRepositorie repo;

  GambleApplication({required super.store, required super.adapter}) {
    repo = GambleRepositorie(adapter);
  }

  Future<Card> gambleCard() async {
    var deck = await repo.doGamble();

    return deck;
  }

  Future<void> claimCard(int cardId) async {
    await repo.claim(cardId);
  }
}

GambleApplication get gambleConnection {
  return GambleApplication(
    adapter: HttpAdapter(loadBearer: true),
    store: appStore,
  );
}
