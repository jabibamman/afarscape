import '../../../domain/entities/post.dart';

abstract class PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedEnd;
  PostLoaded(this.posts, {required this.hasReachedEnd});
}

class PostDeleting extends PostState {}

class PostDeleteSuccess extends PostState {}

class PostDeleteError extends PostState {}

class PostError extends PostState {}
