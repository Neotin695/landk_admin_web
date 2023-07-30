import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'model/model.dart';

abstract class _ManageDelegates {
  Future<void> acceptDelegate(String id);
  Future<void> rejectDelegate(String id, String message);
  Future<void> toggleActiveDelegate(String id, bool state);
  Future<void> deleteDelegate(String id);
  Either<String, Stream<List<Delegate>>> fetchAllDelegates();
  Future<Delegate> fetchDelegate(String id);
  Future<void> searchDelegate(String query);
}

class ManageDelegatesRepository implements _ManageDelegates {
  final FirebaseFirestore _fireStore;

  ManageDelegatesRepository() : _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> deleteDelegate(String id) async {
    await _fireStore.collection('delegates').doc(id).delete();
  }

  @override
  Future<Delegate> fetchDelegate(String id) async {
    return Delegate.fromMap(
      ((await _fireStore.collection('delegates').doc(id).get()).data()
          as Map<String, dynamic>),
    );
  }

  @override
  Either<String, Stream<List<Delegate>>> fetchAllDelegates() {
    try {
      return Right(_fireStore.collection('delegates').snapshots().map(
        (event) {
          return event.docs.map((e) => Delegate.fromMap(e.data())).toList();
        },
      ));
    } catch (er) {
      return Left(er.toString());
    }
  }

  @override
  Future<void> searchDelegate(String query) async {}

  @override
  Future<void> acceptDelegate(String id) async {
    try {
      await _fireStore
          .collection('delegates')
          .doc(id)
          .update({'acceptable': true});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> toggleActiveDelegate(String id, bool state) async {
    try {
      await _fireStore
          .collection('delegates')
          .doc(id)
          .update({'active': state});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> rejectDelegate(String id, String message) async {
    try {
      await _fireStore
          .collection('delegates')
          .doc(id)
          .update({'acceptable': false});
    } catch (e) {
      print(e);
    }
  }
}
