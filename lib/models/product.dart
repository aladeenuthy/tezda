class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final List<String> images;
  final String category;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.images,
      required this.description,
      required this.category});
  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
        id: data['id'].toString(),
        name: data['title'],
        description: data['description'],
        price: (data['price'] as num).toInt(),
        images: [data['image']],
        category: data['category']);
  }
}
