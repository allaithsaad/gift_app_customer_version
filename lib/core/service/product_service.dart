import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _producteCollectionRef =
      FirebaseFirestore.instance.collection('Product');

  final CollectionReference _favoritCollectionRef =
      FirebaseFirestore.instance.collection('Product');

  final CollectionReference _storeProductollectionRef =
      FirebaseFirestore.instance.collection('Product');

  final CollectionReference _categoriesRef =
      FirebaseFirestore.instance.collection('Product');

  Future<List<QueryDocumentSnapshot>> getProduct() async {
    var value = await _producteCollectionRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getStoreProducts(String storeId) async {
    var value = await _storeProductollectionRef
        .where('storeId', isEqualTo: '$storeId')
        .get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getFavorit() async {
    var value =
        await _favoritCollectionRef.where("favorite", isEqualTo: true).get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getCategories(cateId) async {
    print(cateId);
    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    var value =
        await _categoriesRef.where("categoryId", isEqualTo: cateId).get();
    return value.docs;

  }
}
