class ProductModel {
  String id;
  String title;
  String description;
  String image;
  double price;
  String category;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.category});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        id: json['id'],
        price: (json["price"] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'id': id
    };
  }
}
