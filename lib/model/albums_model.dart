import 'dart:convert';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

List<AlbumsModel> albumFromJson(var str) =>
    List<AlbumsModel>.from(str.map((x) => AlbumsModel.fromJson(x)));

String albumToJson(List<AlbumsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@immutable
class AlbumsModel extends Equatable {
  final int? userId;
  final int? id;
  final String? title;

  const AlbumsModel({
    this.userId,
    this.id,
    this.title,
  });

  factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'id': id,
        'title': title,
      };

  @override
  List<Object?> get props => [userId, id, title];

  @override
  bool operator ==(Object other) =>
      other is AlbumsModel &&
      other.userId == userId &&
      other.id == id &&
      other.title == title;

  @override
  int get hashCode => hashValues(userId, id, title);
}
