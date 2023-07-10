import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  String id;
  String imageUrl;
  String name;
  Category({
    required this.id,
    required this.imageUrl,
    required this.name
  });

  @override
  List<Object?> get props => [id, imageUrl,name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'photoUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['photoUrl'] as String,
    );
  }
}
