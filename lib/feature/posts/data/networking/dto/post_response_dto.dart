import 'package:flutter/foundation.dart';
import 'post_dto.dart';

/// Recebe a lista de posts do banco de dados
class PostResponseDto {
  /// Lista de posts
  final List<PostDto> posts;

  PostResponseDto({required this.posts});

  factory PostResponseDto.fromJson(Map<String, dynamic> json) {
    List<dynamic> postsList = json['posts'] ?? [];
    List<PostDto> posts =
        postsList.map((postJson) => PostDto.fromJson(postJson)).toList();

    return PostResponseDto(posts: posts);
  }

  @override
  String toString() => 'PostResponseDto(posts: $posts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostResponseDto && listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}
