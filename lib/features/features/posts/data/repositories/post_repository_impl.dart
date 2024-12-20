import '../datasources/post_datasource.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;

  PostRepositoryImpl({required this.dataSource});

  @override
  Future<List<Post>> getPosts() {
    return dataSource.getAllPosts();
  }

  @override
  Future<Post> createPost(Post post) {
    return dataSource.createPost(post);
  }

  @override
  Future<Post> updatePost(Post post) {
    return dataSource.updatePost(post);
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await dataSource.deletePost(postId);
    } catch (e) {
      throw Exception('Failed to delete post with ID $postId');
    }
  }

  @override
  Future<List<Post>> getPaginatedPosts(int offset, int limit) {
    return dataSource.getPaginatedPosts(offset, limit);
  }
}