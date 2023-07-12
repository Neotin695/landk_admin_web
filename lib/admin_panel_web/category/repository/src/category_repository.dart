import 'model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class _CategoryRepository {
  Future<void> insertCategory(String url,String name);
  Future<void> deleteCategory(String id);
  Stream<List<Category>> fetchAllCategory();
}

class CategoryRepository implements _CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository() : _firestore = FirebaseFirestore.instance;
  @override
  Future<void> deleteCategory(String id) async {
    await _firestore.collection('category').doc(id).delete();
  }

  @override
  Stream<List<Category>> fetchAllCategory() {
    return _firestore.collection('category').snapshots().map((event) {
      return event.docs.map((e) => Category.fromMap(e.data())).toList();
    });
  }

  @override
  Future<void> insertCategory(String url,String name) async {
    final String docId = _firestore.collection('category').doc().id;
    await _firestore
        .collection('category')
        .doc(docId)
        .set(Category(id: docId, imageUrl: url,name: name).toMap());
  }
}
