import 'package:equatable/equatable.dart';

class Onwer extends Equatable {
  final String id;
  final String userName;
  final String phoneNum;
  final String email;

  const Onwer({
    required this.id,
    required this.userName,
    required this.phoneNum,
    required this.email,
  });

  static Onwer empty() =>
      const Onwer(id: '', userName: '', phoneNum: '', email: '');

  @override
  List<Object?> get props => [id, userName, phoneNum, email];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'phoneNum': phoneNum,
      'email': email,
    };
  }

  factory Onwer.fromMap(Map<String, dynamic> map) {
    return Onwer(
      id: map['id'] as String,
      userName: map['userName'] as String,
      phoneNum: map['phoneNum'] as String,
      email: map['email'] as String,
    );
  }
}
