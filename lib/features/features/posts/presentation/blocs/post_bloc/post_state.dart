import '../../../domain/entities/post.dart';

enum PostStatus {
  initial,
  loading,
  loaded,
  creating,
  deleting,
  success,
  error,
  updating,
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedEnd;
  final String? errorMessage;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.hasReachedEnd = false,
    this.errorMessage,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedEnd,
    String? errorMessage,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorMessage: errorMessage,
    );
  }
}
