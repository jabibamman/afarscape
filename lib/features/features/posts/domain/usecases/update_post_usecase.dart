import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/utils/validation_utils.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUsecase {
  final PostRepository repository;

  UpdatePostUsecase(this.repository);

  Future<void> call(Post post) async {
    if (!UrlValidator.isValid(post.imageUrl)) {
      throw InvalidPostException('Image URL is invalid');
    }

    await repository.updatePost(post);
  }
}
