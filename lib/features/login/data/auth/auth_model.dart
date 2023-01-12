class AuthBody {
  String? email;
  String? password;

  AuthBody({this.email, this.password});

  AuthBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? lastName;
  String? email;
  Role? role;
  bool? isActive;

  User(
      {this.id,
      this.name,
      this.lastName,
      this.email,
      this.role,
      this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['isActive'] = isActive;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    return data;
  }
}
