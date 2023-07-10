import 'package:equatable/equatable.dart';
import 'package:manage_user_repository/src/model/address_info.dart';

// ignore: must_be_immutable
class Customer extends Equatable {
  String id;
  String photoUrl;
  bool active;
  String name;
  String email;
  bool isEmailVerified;
  String phoneNum;
  AddressInfo location;
  List<String> orders;

  static Customer empty() => Customer(
      id: '',
      active: false,
      name: '',
      photoUrl: '',
      email: '',
      isEmailVerified: false,
      phoneNum: '',
      location: AddressInfo.empty(),
      orders: const []);

  Customer({
    required this.id,
    required this.active,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.isEmailVerified,
    required this.phoneNum,
    required this.location,
    required this.orders,
  });

  @override
  List<Object> get props {
    return [
      id,
      active,
      name,
      email,
      photoUrl,
      phoneNum,
      isEmailVerified,
      location,
      orders,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'active': active,
      'name': name,
      'isEmailVerified': isEmailVerified,
      'email': email,
      'phoneNum': phoneNum,
      'photoUrl': photoUrl,
      'location': location.toMap(),
      'orders': orders,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
        id: map['id'] as String,
        active: map['active'] as bool,
        photoUrl: map['photoUrl'] as String,
        isEmailVerified: map['isEmailVerified'] as bool,
        name: map['name'] as String,
        email: map['email'] as String,
        phoneNum: map['phoneNum'] as String,
        location: AddressInfo.fromMap(map['location'] as Map<String, dynamic>),
        orders: List.from(map['orders'].map((e) => e)));
  }
}
