class UserState {
  int? id;
  String? name;
  String? lastName;
  String? email;
  RoleState? role;
  bool? isActive;

  UserState({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.role,
    this.isActive,
  });
}

class RoleState {
  int? id;
  String? description;

  RoleState({this.id, this.description});
}
