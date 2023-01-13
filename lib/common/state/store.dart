import 'package:card_nft_app/common/state/app/app_reducer.dart';
import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:redux/redux.dart';

final appStore =
    Store<AppState>(appReducer, initialState: AppState.initialState());
