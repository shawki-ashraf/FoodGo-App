// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;
  final String price;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
    required this.price,
    required String name,
    required String image,
  });

  Map<String, dynamic> toMap() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": spicy,
      "toppings": toppings,
      "side_options": sideOptions,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}

class CartItems {
  List<CartModel> items;
  CartItems({required this.items});

  Map<String, dynamic> toJson() => <String, dynamic>{
    "items": items.map((CartModel e) => e.toJson()).toList(),
  };
}

class ProductToppings {
  final int id;
  final String name;
  final String image;

  ProductToppings({required this.id, required this.name, required this.image});

  factory ProductToppings.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? '';
    if (imageUrl.startsWith('http://')) {
      imageUrl = imageUrl.replaceFirst('http://', 'https://');
    }
    return ProductToppings(id: json['id'], name: json['name'], image: imageUrl);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "image": image};
  }
}

class GetCartResponse {
  final int code;
  final String msg;
  final Cartdata cartdata;

  GetCartResponse({
    required this.code,
    required this.msg,
    required this.cartdata,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      code: json["code"] ?? 200,
      msg: json["message"]?.toString() ?? "",
      cartdata: Cartdata.fromJson(json["data"]),
    );
  }
}

class Cartdata {
  final int id;
  final double totalprice;
  final List<CartItemModel> items;

  Cartdata({required this.id, required this.totalprice, required this.items});

  factory Cartdata.fromJson(Map<String, dynamic> json) {
    return Cartdata(
      id: json["id"] ?? 0,
      totalprice: double.tryParse(json["total_price"]?.toString() ?? "0") ?? 0,
      items: (json["items"] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }
}

class CartItemModel {
  final int itemId;
  final int productId;
  final String name;
  final String price;
  final int quantity;
  final String image;
  final String spicy;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.spicy,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = json["image"] ?? "";
    if (imageUrl.startsWith("http://")) {
      imageUrl = imageUrl.replaceFirst("http://", "https://");
    }
    return CartItemModel(
      itemId: json["item_id"] ?? 0,
      productId: json["product_id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"]?.toString() ?? "0",
      quantity: json["quantity"] ?? 1,
      image: imageUrl,
      spicy: json["spicy"]?.toString() ?? "",
    );
  }
}
