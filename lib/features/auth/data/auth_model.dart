import 'package:card_nft_app/features/auth/application/auth_view_model.dart';

class AuthBody {
  String? email;
  String? password;

  AuthBody({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class AuthResponse {
  late User user;
  late String token;

  AuthResponse({required this.user, required this.token});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    token = json['token'];
  }
}

class User {
  int? id;
  String? name;
  String? lastName;
  String? email;
  Role? role;
  bool? isActive;

  User({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.role,
    this.isActive,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    isActive = json['isActive'];
  }
}

class Role {
  int? id;
  String? description;

  Role({this.id, this.description});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }
}

class NewUserBody extends NewUserModel {
  NewUserBody({
    required super.name,
    required super.lastName,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class UserRegisterResponse {
  late final int id;
  late final String name;
  late final String lastName;
  late final String email;
  late final Role role;
  late final bool isActive;

  UserRegisterResponse({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isActive,
  });

  UserRegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    role = Role.fromJson(json['role']);
    isActive = json['isActive'];
  }
}
