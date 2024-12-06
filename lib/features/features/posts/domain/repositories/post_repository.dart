import '../entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPaginatedPosts(int offset, int limit);
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(Post post);
}
