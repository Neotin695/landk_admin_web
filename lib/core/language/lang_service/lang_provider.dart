import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class _LangService {
  Future<bool> exists();
  Future<void> changeLang(String localeCode);
}

class LangSerivce implements _LangService {
  late final FirebaseFirestore _firestore;

  LangSerivce() : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> changeLang(String localeCode) async {
    final docId = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('languages').doc(docId).set({
      'id': docId,
      'langCode': localeCode,
    });
  }

  @override
  Future<bool> exists() async {
    bool exists = false;
    try {
      final test = await _firestore.collection('languages').get();
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return exists;
  }
}
