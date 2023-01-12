class JWTDecoded {
  late final int id;
  late final String name;
  late final String lastName;
  late final String email;
  late final Role role;
  late final bool isActive;
  late final int iat;
  late final int exp;

  JWTDecoded({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isActive,
    required this.iat,
    required this.exp,
  });

  JWTDecoded.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    role = Role.fromJson(json['role']);
    isActive = json['isActive'];
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['role'] = role.toJson();
    data['isActive'] = isActive;
    data['iat'] = iat;
    data['exp'] = exp;
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
