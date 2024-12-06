import '../../../../../core/utils/result.dart';
import '../repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<Result<void>> call(String postId) async {
    try {
      await repository.deletePost(postId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
