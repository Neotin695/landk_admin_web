import 'model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class _BannerRepository {
  Future<void> insertBanner(String url);
  Future<void> deleteBanner(String id);
  Stream<List<Banner>> fetchAllBanners();
}

class BannerRepository implements _BannerRepository {
  final FirebaseFirestore _firestore;

  BannerRepository() : _firestore = FirebaseFirestore.instance;
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
  Future<void> insertBanner(String url) async {
    final String docId = _firestore.collection('banners').doc().id;
    await _firestore
        .collection('banners')
        .doc(docId)
        .set(Banner(id: docId, photoUrl: url).toMap());
  }
}
