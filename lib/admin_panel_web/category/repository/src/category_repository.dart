import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/category.dart';

abstract class _CategoryRepository {
  Future<TaskState> insertCategory(Uint8List url, String name);
  Future<void> deleteCategory(String id);
  Stream<List<Category>> fetchAllCategory();
}

class CategoryRepository implements _CategoryRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  CategoryRepository()
      : _firestore = FirebaseFirestore.instance,
        _firebaseStorage = FirebaseStorage.instance;
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
  Future<TaskState> insertCategory(Uint8List url, String name) async {
    final String docId = _firestore.collection('category').doc().id;

    try {
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      final snapshot = await _firebaseStorage
          .ref('category')
          .child('$name.jpeg')
          .putData(url, metadata);
      if (snapshot.state == TaskState.success) {
        await _firestore.collection('category').doc(docId).set(Category(
                id: docId,
                imageUrl: await snapshot.ref.getDownloadURL(),
                name: name)
            .toMap());
        return TaskState.success;
      } else if (snapshot.state == TaskState.running) {
        return TaskState.running;
      } else if (snapshot.state == TaskState.canceled) {
        print('category error');

        return TaskState.canceled;
      } else {
        return TaskState.error;
      }
    } catch (e) {
      print(e);
      return TaskState.error;
    }
  }
}
