class User {
  final String token;
  String? name;
  String? lastName;

  User({
    required this.token,
    this.name,
    this.lastName,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
    token: json['token'] as String,
  );

  User.fullFromJson(Map<String, Object?> json)
      : this(
    token: json['token'] as String,
    name: json['firstName'] as String,
    lastName: json['lastName'] as String,
  );
}
