import 'package:church_app/feature/posts/data/mappers/post_mapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/networking/supabase_query_wrapper.dart';
import '../../domain/post.dart';
import '../../domain/post_data_source.dart';
import 'dto/post_dto.dart';

class RemotePostDataSource implements PostDataSource {
  final SupabaseClient _supabase;

  RemotePostDataSource({required SupabaseClient supabaseClient})
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
}
