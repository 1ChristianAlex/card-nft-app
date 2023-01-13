import 'package:card_nft_app/common/application_data/application_state.dart';
import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/jwt_manager/jwt_manager.dart';
import 'package:card_nft_app/common/state/store.dart';
import 'package:card_nft_app/common/state/user/user_actions.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';
import 'package:card_nft_app/features/auth/application/auth_view_model.dart';
import 'package:card_nft_app/features/auth/data/auth_model.dart';
import 'package:card_nft_app/features/auth/data/auth_repo.dart';

class AuthAplication extends ApplicationState {
  late AuthRepositorie repo;

  AuthAplication({required super.store, required super.adapter}) {
    repo = AuthRepositorie(adapter);
  }

  Future<AuthResponse> doLogin(String email, String password) async {
    var authResponse = await repo.login(email, password);

    await JWTManager().set(authResponse.token);

    store.dispatch(
      updateUser(
        UserState(
          email: authResponse.user.email,
          id: authResponse.user.id,
          isActive: authResponse.user.isActive,
          lastName: authResponse.user.lastName,
          name: authResponse.user.name,
          role: RoleState(
            description: authResponse.user.role?.description ?? '',
            id: authResponse.user.role!.id,
          ),
        ),
      ),
    );

    return authResponse;
  }

  Future<UserRegisterResponse> register(NewUserModel register) async {
    var userRegister = await repo.register(register);

    return userRegister;
  }

  Future<void> loadUserFromToken() async {
    var jwtManager = JWTManager();
    if (store.state.user == null && await jwtManager.isAuth()) {
      var user = await jwtManager.decode();

      store.dispatch(
        updateUser(
          UserState(
            email: user.email,
            id: user.id,
            isActive: user.isActive,
            lastName: user.lastName,
            name: user.name,
            role: RoleState(
              description: user.role.description ?? '',
              id: user.role.id,
            ),
          ),
        ),
      );
    }
  }

  Future<void> logout() async {
    await JWTManager().delete();
    store.dispatch(removeUser());
  }
}

AuthAplication get authConnetion {
  return AuthAplication(
    adapter: HttpAdapter(loadBearer: true),
    store: appStore,
  );
}
