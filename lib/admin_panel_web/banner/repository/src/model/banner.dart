// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Banner extends Equatable {
  String id;
  String photoUrl;
  FieldValue createdDate;
  FieldValue updatedDate;
  Banner({
    required this.id,
    required this.photoUrl,
    required this.createdDate,
    required this.updatedDate,
  });

@override
List<Object?> get props => [id, photoUrl, createdDate, updatedDate];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photoUrl': photoUrl,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'] as String,
      photoUrl: map['photoUrl'] as String,
      createdDate: map['createdDate'] as FieldValue,
      updatedDate: map['updatedDate'] as FieldValue,
    );
  }

}
