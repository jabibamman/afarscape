import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PostEvent {}
class LoadPosts extends PostEvent {}

abstract class PostState {}
class PostLoading extends PostState {}
class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}
class PostError extends PostState {}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(PostLoading()) {
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.getPosts();
        emit(PostLoaded(posts));
      } catch (_) {
        emit(PostError());
      }
    });
  }
}
