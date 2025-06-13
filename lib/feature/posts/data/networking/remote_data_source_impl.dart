import 'package:church_app/feature/posts/data/mappers/comment_mapper.dart';
import 'package:church_app/feature/posts/data/mappers/post_mapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/networking/supabase_query_wrapper.dart';
import '../../domain/comment.dart';
import '../../domain/post.dart';
import '../../domain/remote_data_source.dart';
import 'dto/comment_dto.dart';
import 'dto/post_dto.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient _supabase;

  RemoteDataSourceImpl({required SupabaseClient supabaseClient})
    : _supabase = supabaseClient;

  @override
  Future<List<Post>> getPosts({int limit = 20, int offset = 0}) async {
    return executeSupabaseQuery<Post>(
      query:
          () => _supabase
              .from('posts_with_user_info')
              .select()
              .order('created_at', ascending: false)
              .range(offset, offset + limit - 1),
      converter: (json) => PostDto.fromJson(json).toPost(),
      errorMessage: 'Failed to fetch posts',
    );
  }

  @override
  Future<List<Comment>> getComments(
    int postId, {
    int limit = 20,
    int offset = 0,
  }) async {
    return executeSupabaseQuery<Comment>(
      query:
          () => _supabase
              .from('comment_with_user_info')
              .select()
              .eq('post_id', postId)
              .order('created_at', ascending: false)
              .range(offset, offset + limit - 1),
      converter: (json) => CommentDto.fromJson(json).toComment(),
      errorMessage: 'Failed to fetch comments',
    );
  }

  @override
  Future<void> sendComment(
    int postId,
    String comment,
    String? imageUrl,
    String? videoUrl,
  ) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }

    final userId = user.id;
    final response = await _supabase.from('comments').insert({
      'post_id': postId,
      'user_id': userId,
      'text': comment,
      'image_url': imageUrl,
      'video_url': videoUrl,
    });
  }
}
