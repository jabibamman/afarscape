import 'dart:async';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/post.dart';
import 'post_datasource.dart';

class FakePostsDataSource extends PostDataSource {
  final List<Post> _fakePosts = [
    const Post(id: '1', title: 'Lake Assal', description: 'The saltiest lake in the world and the lowest point in Africa.'),
    const Post(id: '2', title: 'Moucha Island', description: 'A beautiful coral island, perfect for snorkeling and diving.'),
    const Post(id: '3', title: 'Arta Beach', description: 'A popular spot for swimming alongside whale sharks.'),
    const Post(id: '4', title: 'Day Forest National Park', description: 'A lush green oasis in Djibouti, home to unique wildlife.'),
    const Post(id: '5', title: 'Lake Abbe', description: 'A surreal landscape with limestone chimneys and a boiling lake.'),
    const Post(id: '6', title: 'Djibouti City', description: 'The vibrant capital city, offering markets, colonial architecture, an, sea views.'),
    const Post(id: '7', title: 'Tadjourah', description: 'One of Djibouti’s oldest towns, known for its whitewashed houses and rich history.'),
    const Post(id: '8', title: 'Doralé Beach', description: 'A pristine beach near Djibouti City, ideal for relaxation and sea views.'),
    const Post(id: '9', title: 'Ghoubbet Al-Kharab', description: 'The "Gulf of Demons," known for its mysterious waters and strong currents.'),
    const Post(id: '10', title: 'Ali Sabieh Desert', description: 'A vast desert offering stunning red and golden sand dunes.'),
    const Post(id: '11', title: 'Goda Mountains', description: 'A picturesque mountain range with breathtaking views and cool temperatures.'),
    const Post(id: '12', title: 'The Grand Bara Desert', description: 'A vast expanse of white sand, perfect for adventure and exploration.'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<List<Post>> getPaginatedPosts(int offset, int limit) async {
    await Future.delayed(const Duration(seconds: 1));
    if (offset >= _fakePosts.length) {
      return [];
    }
    return _fakePosts.sublist(
      offset,
      (offset + limit) > _fakePosts.length ? _fakePosts.length : offset + limit,
    );
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
      throw PostNotFoundException('Post with id ${updatedPost.id} not found.');
    }
  }

  @override
  Future<void> deletePost(Post post) {
    throw UnimplementedFeatureException('Delete Post');
  }

}