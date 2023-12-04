class User {
  final String? name;
  final String? password;
  final String? email;

  User(this.name, this.password, this.email);

  factory User.createFromJson(Map<String, dynamic> json) {
    return User(json['name'] as String?, json['password'] as String?,
        json['email'] as String?);
  }
}
