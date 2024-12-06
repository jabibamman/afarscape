import '../../domain/entities/post.dart';

class FakePostDataSource {
  final List<Post> _fakePosts = [
    const Post(id: '1', title: 'Lake Assal', description: 'The saltiest lake in the world.'),
    const Post(id: '2', title: 'Moucha Island', description: 'A beautiful coral island in Djibouti.'),
  ];

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }
}
