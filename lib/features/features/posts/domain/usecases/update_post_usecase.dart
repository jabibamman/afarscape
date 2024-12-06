import '../../../../../core/utils/result.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUsecase {
  final PostRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Result<void>> call(Post post) async {
    try {
      await repository.updatePost(post);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}