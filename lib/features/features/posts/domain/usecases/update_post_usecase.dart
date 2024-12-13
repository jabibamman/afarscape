import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUsecase {
  final PostRepository repository;

  UpdatePostUsecase(this.repository);

  Future<void> call(Post post) async {
    await repository.updatePost(post);
  }
}
