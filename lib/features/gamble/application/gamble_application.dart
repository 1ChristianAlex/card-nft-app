import 'package:card_nft_app/common/application_data/application_state.dart';
import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/features/dashboard/application/deck_application.dart';
import 'package:card_nft_app/features/gamble/application/gample_model.dart';
import 'package:card_nft_app/features/gamble/data/gamble_repo.dart';

class GambleApplication extends ApplicationState {
  late GambleRepositorie repo;

  GambleApplication({required super.store, required super.adapter}) {
    repo = GambleRepositorie(adapter);
  }

  Future<GambleModel> gambleCard() async {
    var response = await repo.doGamble();

    return GambleModel(
      card: response.card!,
      expiresInSeconds: response.expiresInSeconds!,
    );
  }

  Future<void> claimCard(int cardId) async {
    await repo.claim(cardId);
    await deckConnection.getDeckAndDispatch();
  }
}

GambleApplication get gambleConnection {
  return GambleApplication(
    adapter: HttpAdapter(loadBearer: true),
    store: appStore,
  );
}
