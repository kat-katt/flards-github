import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String name;
  final String description;
  final String tags;
  final bool isPrivate;
  final String userId;

  Item({
    required this.id,
    required this.name,
    this.description = '',
    this.tags = '',
    this.isPrivate = true,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tags': tags,
      'isPrivate': isPrivate,
      'user_id': userId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      name: map['title'] ?? map['name'] ?? '',
      description: map['description'] ?? '',
      tags: map['tags'] ?? '',
      isPrivate: map['isPrivate'] ?? true,
      userId: map['user_id'] ?? '',
    );
  }
}
