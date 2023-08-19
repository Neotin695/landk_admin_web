import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Banner extends Equatable {
  String id;
  String photoUrl;

  Banner({
    required this.id,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        photoUrl,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photoUrl': photoUrl,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }
}
