class User {
  final int id;
  final String name;
  final String email;

  const User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
    );
  }
}
