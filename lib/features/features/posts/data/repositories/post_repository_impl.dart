import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/fake_post_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final FakePostDataSource dataSource;

  PostRepositoryImpl({required this.dataSource});

  @override
  Future<List<Post>> getPosts() {
    return dataSource.fetchPosts();
  }
}
