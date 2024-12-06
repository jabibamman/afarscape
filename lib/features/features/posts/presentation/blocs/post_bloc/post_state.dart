import '../../../domain/entities/post.dart';

abstract class PostState {}
class PostLoading extends PostState {}
class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedEnd;

  PostLoaded(this.posts, {this.hasReachedEnd = false});
}
class PostError extends PostState {}