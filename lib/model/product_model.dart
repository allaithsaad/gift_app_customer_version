class ProductModel {
  String name, image, description, storeId, componentId;
  bool available, favorite;
  int discount, price, popular,productId,categoryId;

  ProductModel({
    this.name,
    this.image,
    this.description,
    this.price,
    this.available,
    this.discount,
    this.storeId,
    this.favorite,
    this.popular,
    this.componentId,
    this.productId,
    this.categoryId,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    discount = map['discount'];
    available = map['available'];
    storeId = map['storeId'];
    favorite = map['favorite'];
    popular = map['popular'];
    componentId = map['componentId'];
    productId = map['productId'];
    categoryId = map['categoryId'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'discount': discount,
      'available': available,
      'storeId': storeId,
      'favorite': favorite,
      'popular': popular,
      'componentId': componentId,
      'categoryId': categoryId,
    };
  }
}
