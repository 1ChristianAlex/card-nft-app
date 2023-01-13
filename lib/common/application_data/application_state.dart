import 'package:card_nft_app/common/application_data/application_connection.dart';
import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:redux/redux.dart';

abstract class ApplicationState extends ApplicationConnection {
  final Store<AppState> store;

  ApplicationState({required super.adapter, required this.store});
}
