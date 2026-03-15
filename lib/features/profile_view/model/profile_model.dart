class ProfileModel {
  final String username;
  final String email;
  final String profileImageUrl;
  final String visa;
  final String address;

  ProfileModel({
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.visa,
    required this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? '';

    if (imageUrl.startsWith('http://')) {
      imageUrl = imageUrl.replaceFirst('http://', 'https://');
    }
    return ProfileModel(
      username: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImageUrl: imageUrl,
      visa: json['Visa'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
