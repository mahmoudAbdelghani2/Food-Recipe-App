class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String gender;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
    );
  }

  String get userImage {
    return gender == "Male"
        ? "assets/images/male_avatar.png"
        : "assets/images/female_avatar.png";
  }
}
