import 'dart:async';
import '../../domain/entities/post.dart';
import 'post_datasource.dart';

class FakePostsDataSource extends PostDataSource {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Lake Assal', description: 'The saltiest lake in the world.'),
    Post(id: '2', title: 'Moucha Island', description: 'A beautiful coral island in Djibouti.'),
    Post(id: '3', title: 'Arta Beach', description: 'A popular snorkeling spot with incredible marine life.'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: postToAdd.title,
      description: postToAdd.description,
    );
    _fakePosts.add(newPost);
    return newPost;
  }

  @override
  Future<Post> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
      return updatedPost;
    } else {
      throw Exception('Post not found');
    }
  }

  @override
  Future<void> deletePost(Post post) {
    throw UnimplementedError();
  }
}