// ignore_for_file: public_member_api_docs, sort_constructors_first

class Productsmodel {
  final int id;
  final String name;
  final String dec;
  final String rate;
  final String image;
  final String price;

  Productsmodel({
    required this.id,
    required this.name,
    required this.dec,
    required this.rate,
    required this.image,
    required this.price,
  });

  factory Productsmodel.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] as String;

    // تحويل HTTP إلى HTTPS
    if (imageUrl.startsWith("http://")) {
      imageUrl = imageUrl.replaceFirst("http://", "https://");
    }

    return Productsmodel(
      id: json['id'] as int,
      name: json['name'] as String,
      dec: json['description'] as String,
      rate: json['rating'].toString(), // خليها String لو ممكن تجي Double
      image: imageUrl,
      price: json['price'].toString(),
    );
  }
}
