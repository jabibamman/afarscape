import 'package:afarscape/features/features/posts/data/datasources/post_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:afarscape/features/features/posts/data/repositories/post_repository_impl.dart';
import 'package:afarscape/features/features/posts/domain/entities/post.dart';

import 'package:mockito/annotations.dart';
import 'post_datasource.mocks.dart';

@GenerateMocks([PostDataSource])
void main() {
  late PostRepositoryImpl repository;
  late MockPostDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPostDataSource();
    repository = PostRepositoryImpl(dataSource: mockDataSource);
  });

  test('getPosts should fetch all posts from the datasource', () async {
    when(mockDataSource.getAllPosts()).thenAnswer((_) async => <Post>[]);
    final posts = await repository.getPosts();
    expect(posts, isA<List<Post>>());
    verify(mockDataSource.getAllPosts()).called(1);
  });

  test('createPost should delegate to the datasource', () async {
    const post = Post(id: '1', title: 'New Post', description: 'Description');
    when(mockDataSource.createPost(post)).thenAnswer((_) async => post);

    final result = await repository.createPost(post);
    expect(result, post);
    verify(mockDataSource.createPost(post)).called(1);
  });

  test('getPaginatedPosts should fetch paginated posts from the datasource', () async {
    const offset = 0;
    const limit = 5;
    final fakePosts = List.generate(limit, (i) => Post(id: '$i', title: 'Post $i', description: 'Description $i'));

    when(mockDataSource.getPaginatedPosts(offset, limit)).thenAnswer((_) async => fakePosts);

    final posts = await repository.getPaginatedPosts(offset, limit);
    expect(posts, fakePosts);
    verify(mockDataSource.getPaginatedPosts(offset, limit)).called(1);
  });

  test('updatePost should update a post through the datasource', () async {
    const updatedPost = Post(id: '1', title: 'Updated Post', description: 'Updated Description');

    when(mockDataSource.updatePost(updatedPost)).thenAnswer((_) async => updatedPost);

    final result = await repository.updatePost(updatedPost);
    expect(result, updatedPost);
    verify(mockDataSource.updatePost(updatedPost)).called(1);
  });

  test('updatePost should throw an exception when datasource fails', () async {
    const updatedPost = Post(id: '1', title: 'Updated Post', description: 'Updated Description');

    when(mockDataSource.updatePost(updatedPost)).thenThrow(Exception('Update failed'));

    expect(() => repository.updatePost(updatedPost), throwsException);
    verify(mockDataSource.updatePost(updatedPost)).called(1);
  });

  test('getPosts should throw an exception when datasource fails', () async {
    when(mockDataSource.getAllPosts()).thenThrow(Exception('Fetch failed'));

    expect(() => repository.getPosts(), throwsException);
    verify(mockDataSource.getAllPosts()).called(1);
  });

}
