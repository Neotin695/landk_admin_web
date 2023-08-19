import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'model/model.dart';

abstract class _BannerRepository {
  Future<TaskState> insertBanner(Uint8List url);
  Future<void> deleteBanner(String id);
  Either<String, Stream<List<Banner>>> fetchAllBanners();
}

class BannerRepository implements _BannerRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  BannerRepository()
      : _firestore = FirebaseFirestore.instance,
        _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<void> deleteBanner(String id) async {
    _firebaseStorage.ref('banners').child(id).delete().then((value) async =>
        await _firestore.collection('banners').doc(id).delete());
  }

  @override
  Either<String, Stream<List<Banner>>> fetchAllBanners() {
    try {
      return Right(_firestore.collection('banners').snapshots().map(
        (event) {
          return event.docs.map((e) => Banner.fromMap(e.data())).toList();
        },
      ));
    } catch (er) {
      print(er);
      return Left(er.toString());
    }
  }

  @override
  Future<TaskState> insertBanner(Uint8List url) async {
    final String docId = _firestore.collection('banners').doc().id;
    try {
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      final snapshot = await _firebaseStorage
          .ref('banners')
          .child('$docId.jpeg')
          .putData(url, metadata);

      if (snapshot.state == TaskState.success) {
        await _firestore.collection('banners').doc(docId).set(Banner(
              id: docId,
              photoUrl: await snapshot.ref.getDownloadURL(),
            ).toMap());
        return TaskState.success;
      } else if (snapshot.state == TaskState.running) {
        return TaskState.running;
      } else if (snapshot.state == TaskState.canceled) {
        print('banner error');
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
