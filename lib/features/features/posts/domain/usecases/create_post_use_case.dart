import '../entities/post.dart';
import '../repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<void> call(Post post) async {
    await repository.createPost(post);
  }
}