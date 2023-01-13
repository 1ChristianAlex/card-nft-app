import 'package:card_nft_app/common/state/action_creator.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';

enum UserActions {
  update(1),
  remove(2),
  ;

  final int code;

  const UserActions(
    this.code,
  );

  String getUpperCaseName() {
    return name.toUpperCase();
  }
}

ActionCreator<UserState> updateUser(UserState user) {
  return ActionCreator(
    type: UserActions.update,
    payload: UserState(
      email: user.email,
      id: user.id,
      isActive: user.isActive,
      lastName: user.lastName,
      name: user.name,
      role: user.role,
    ),
  );
}

ActionCreator<UserState> removeUser() {
  return ActionCreator<UserState>(
    type: UserActions.remove,
    payload: null,
  );
}
