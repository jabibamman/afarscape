import '../../../domain/entities/post.dart';

abstract class PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {}
