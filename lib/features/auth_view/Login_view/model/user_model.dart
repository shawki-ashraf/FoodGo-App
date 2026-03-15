// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? visa;
  final String? token;
  final String? address;
  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.visa,
    this.token,
    this.address,
  });
  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      token: json["token"] ?? "",
      visa: json["Visa"],
      address: json["address"],
    );
  }
}
