import 'package:afarscape/core/errors/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:afarscape/features/features/posts/data/datasources/fake_post_datasource.dart';
import 'package:afarscape/features/features/posts/domain/entities/post.dart';

void main() {
  late FakePostsDataSource dataSource;

  setUp(() {
    dataSource = FakePostsDataSource();
  });

  test('getAllPosts should return all posts', () async {
    final posts = await dataSource.getAllPosts();
    expect(posts.length, 12);
    expect(posts.first.title, 'Lake Assal');
  });

  test('getPaginatedPosts should return paginated posts', () async {
    final posts = await dataSource.getPaginatedPosts(0, 5);
    expect(posts.length, 5);
    expect(posts.last.title, 'Lake Abbe');
  });

  test('createPost should add a new post', () async {
    const newPost = Post(id: '13', title: 'New Post', description: 'Description of the new post');
    final addedPost = await dataSource.createPost(newPost);

    expect(addedPost.title, 'New Post');
    final allPosts = await dataSource.getAllPosts();
    expect(allPosts.length, 13);
  });

  test('updatePost should update an existing post', () async {
    const updatedPost = Post(id: '1', title: 'Updated Lake Assal', description: 'Updated description');
    final post = await dataSource.updatePost(updatedPost);

    expect(post.title, 'Updated Lake Assal');
    final allPosts = await dataSource.getAllPosts();
    expect(allPosts.first.title, 'Updated Lake Assal');
  });

  test('updatePost should throw PostNotFoundException for non-existent post', () async {
    const nonExistentPost = Post(id: '999', title: 'Non-existent', description: 'Does not exist');
    expect(
          () => dataSource.updatePost(nonExistentPost),
      throwsA(isA<PostNotFoundException>()),
    );
  });
}
