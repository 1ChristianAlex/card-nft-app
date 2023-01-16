import 'package:card_nft_app/common/application_data/application_state.dart';
import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/features/card/application/card_model.dart';
import 'package:card_nft_app/features/gumble/data/gumble_repo.dart';

class GumbleApplication extends ApplicationState {
  late GumbleRepositorie repo;

  GumbleApplication({required super.store, required super.adapter}) {
    repo = GumbleRepositorie(adapter);
  }

  Future<Card> gumbleCard() async {
    var deck = await repo.doGumble();

    return deck;
  }
}

GumbleApplication get gumbleConnection {
  return GumbleApplication(
    adapter: HttpAdapter(loadBearer: true),
    store: appStore,
  );
}
