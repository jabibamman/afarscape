import 'dart:async';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/post.dart';
import 'post_datasource.dart';

class FakePostsDataSource extends PostDataSource {
  final List<Post> _fakePosts = [
    const Post(id: '1', title: 'Lake Assal', description: 'The saltiest lake in the world and the lowest point in Africa.', imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/8f/5a/87/lake-assal.jpg?w=1200&h=1200&s=1'),
    const Post(id: '2', title: 'Moucha Island', description: 'A beautiful coral island, perfect for snorkeling and diving.', imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/25/39/2f/e4/moucha-island-is-a-coral.jpg?w=1200&h=-1&s=1'),
    const Post(id: '3', title: 'Arta Beach', description: 'A popular spot for swimming alongside whale sharks.', imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/92/e9/fb/dsc-0079-1-largejpg.jpg?w=500&h=500&s=1'),
    const Post(id: '4', title: 'Day Forest National Park', description: 'A lush green oasis in Djibouti, home to unique wildlife.', imageUrl: 'https://guide.visitdjibouti.dj/wp-content/uploads/2019/03/DOM4104-e1552200640438.jpg'),
    const Post(id: '5', title: 'Lake Abbe', description: 'A surreal landscape with limestone chimneys and a boiling lake.', imageUrl: 'https://ychef.files.bbci.co.uk/1280x720/p08r2kbw.jpg'),
    const Post(id: '6', title: 'Djibouti City', description: 'The vibrant capital city, offering markets, colonial architecture, an, sea views.', imageUrl: 'https://toposmagazine.com/wp-content/uploads/2021/07/b_district-1024x572.jpg'),
    const Post(id: '7', title: 'Tadjourah', description: 'One of Djibouti’s oldest towns, known for its whitewashed houses and rich history.', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/ce/Tagore.jpg'),
    const Post(id: '8', title: 'Doralé Beach', description: 'A pristine beach near Djibouti City, ideal for relaxation and sea views.', imageUrl: 'https://sandee.com/_next/image?url=https%3A%2F%2Fcdn.sandee.com%2F65600_390_260.avif&w=3840&q=75'),
    const Post(id: '9', title: 'Ghoubbet Al-Kharab', description: 'The "Gulf of Demons," known for its mysterious waters and strong currents.', imageUrl: 'https://heroesofadventure.com/wp-content/uploads/2019/01/b7f058b2b22852f4a39380062fae2f61.jpg'),
    const Post(id: '10', title: 'Ali Sabieh Desert', description: 'A vast desert offering stunning red and golden sand dunes.', imageUrl: 'https://static1.evcdn.net/images/reduction/1595070_w-3840_h-3840_q-70_m-crop.jpg'),
    const Post(id: '11', title: 'Goda Mountains', description: 'A picturesque mountain range with breathtaking views and cool temperatures.', imageUrl: 'https://heroesofadventure.com/wp-content/uploads/2019/01/GettyImages-148731578_high.jpg'),
    const Post(id: '12', title: 'The Grand Bara Desert', description: 'A vast expanse of white sand, perfect for adventure and exploration.', imageUrl: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgd1sbL7x2_ZVNChIE-v7r1PwgkahB35pRcUBT90-eQlgjpxWU5TyueHL-qk0B3AWHAxjhlzCpygxPciEJDbD0Q7bGCsXnxLGw9dN_acu3VAH7I8unVDv4qUH95m8EAOTYjuThL0DUCn_w/s1600/DSC_0014.JPG'),
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
    _fakePosts.insert(0, postToAdd);
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
  Future<void> deletePost(String postId) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      _fakePosts.removeAt(index);
    } else {
      throw PostNotFoundException('Post with id $postId not found.');
    }
  }

}