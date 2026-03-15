class productcart {
  int? code;
  String? message;
  List<Data>? data;

  productcart({this.code, this.message, this.data});

  productcart.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? status;
  String? totalPrice;
  String? createdAt;
  String? productImage;

  Data({
    this.id,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.productImage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];

    // تحويل http إلى https تلقائيًا
    String? img = json['product_image'];
    if (img != null && img.startsWith('http://')) {
      img = img.replaceFirst('http://', 'https://');
    }
    productImage = img;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['product_image'] = productImage;
    return data;
  }
}
