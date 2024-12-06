import '../../../domain/entities/post.dart';

abstract class PostEvent {}

class LoadPosts extends PostEvent {}
class LoadMorePosts extends PostEvent {}
class UpdatePostEvent extends PostEvent {
  final Post updatedPost;
  UpdatePostEvent(this.updatedPost);
}
class DeletePostEvent extends PostEvent {
  final String postId;
  DeletePostEvent(this.postId);
}
