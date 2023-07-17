// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../../models/model.dart';

// ignore: must_be_immutable
class Delegate extends Equatable {
  String id;
  String photoUrl;
  String birthOfDate;
  String vehicleNum;
  String name;
  IdCard idCard;
  String phoneNum;
  String email;
  String token;
  bool active;
  bool acceptable;
  bool isEmailVerified;
  bool available;
  AddressInfo location;
  List<String> vehicleImages;

  Delegate({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.idCard,
    required this.phoneNum,
    required this.email,
    required this.token,
    required this.active,
    required this.acceptable,
    required this.isEmailVerified,
    required this.location,
    required this.available,
    required this.birthOfDate,
    required this.vehicleNum,
    required this.vehicleImages,
  });

  static Delegate empty() => Delegate(
        id: '',
        photoUrl: '',
        name: '',
        idCard: IdCard.empty(),
        phoneNum: '',
        email: '',
        token: '',
        acceptable: false,
        active: false,
        isEmailVerified: false,
        location: AddressInfo.empty(),
        available: false,
        birthOfDate: '',
        vehicleNum: '',
        vehicleImages: const [],
      );

  @override
  List<Object?> get props => [
        id,
        photoUrl,
        name,
        idCard,
        phoneNum,
        email,
        active,
        isEmailVerified,
        location,
        token,
        acceptable,
        available,
        birthOfDate,
        vehicleNum,
        vehicleImages
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photoUrl': photoUrl,
      'name': name,
      'idCard': idCard.toMap(),
      'phoneNum': phoneNum,
      'email': email,
      'acceptable': acceptable,
      'active': active,
      'token': token,
      'isEmailVerified': isEmailVerified,
      'location': location.toMap(),
      'available': available,
      'birthOfDate': birthOfDate,
      'vehicleNum': vehicleNum,
      'vehicleImages': vehicleImages,
    };
  }

  factory Delegate.fromMap(Map<String, dynamic> map) {
    return Delegate(
      id: map['id'] as String,
      photoUrl: map['photoUrl'] as String,
      name: map['name'] as String,
      idCard: IdCard.fromMap(map['idCard'] as Map<String, dynamic>),
      phoneNum: map['phoneNum'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      acceptable: map['acceptable'] as bool,
      active: map['active'] as bool,
      isEmailVerified: map['isEmailVerified'] as bool,
      location: AddressInfo.fromMap(map['location'] as Map<String, dynamic>),
      available: map['available'] as bool,
      birthOfDate: map['birthOfDate'] as String,
      vehicleNum: map['vehicleNum'] as String,
      vehicleImages: List<String>.from((map['vehicleImages'].map((e) => e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Delegate.fromJson(String source) =>
      Delegate.fromMap(json.decode(source) as Map<String, dynamic>);
}
