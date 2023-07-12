import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'model/model.dart';

abstract class _BannerRepository {
  Future<void> insertBanner(Uint8List url);
  Future<void> deleteBanner(String id);
  Stream<List<Banner>> fetchAllBanners();
}

class BannerRepository implements _BannerRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  BannerRepository()
      : _firestore = FirebaseFirestore.instance,
        _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<void> deleteBanner(String id) async {
    await _firestore.collection('banners').doc(id).delete();
  }

  @override
  Stream<List<Banner>> fetchAllBanners() {
    return _firestore.collection('banners').snapshots().map((event) {
      return event.docs.map((e) => Banner.fromMap(e.data())).toList();
    });
  }

  @override
  Future<void> insertBanner(Uint8List url) async {
    final String docId = _firestore.collection('banners').doc().id;
    try {
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      final snapshot = await _firebaseStorage
          .ref('banners')
          .child('${Timestamp.now().microsecondsSinceEpoch}.jpeg')
          .putData(url, metadata);

      if (snapshot.state == TaskState.success) {
        await _firestore.collection('banners').doc(docId).set(
            Banner(id: docId, photoUrl: await snapshot.ref.getDownloadURL())
                .toMap());
      }
    } catch (e) {
      print(e);
    }
  }
}
 