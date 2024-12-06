import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_event.dart';
import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_state.dart';

import '../../../domain/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUsecase updatePostUsecase;

  static const int _pageSize = 10;
  int _currentOffset = 0;

  PostBloc({ required this.updatePostUsecase, required this.deletePostUseCase, required this.repository}) : super(PostLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<UpdatePostEvent>(_onUpdatePost);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    _currentOffset = 0;
    try {
      final posts = await repository.getPaginatedPosts(_currentOffset, _pageSize);
      _currentOffset += posts.length;
      emit(PostLoaded(posts, hasReachedEnd: posts.length < _pageSize));
    } catch (_) {
      emit(PostError());
    }
  }

  Future<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostState> emit) async {
    if (state is PostLoaded) {
      final currentState = state as PostLoaded;
      if (currentState.hasReachedEnd) return;
      try {
        final newPosts = await repository.getPaginatedPosts(_currentOffset, _pageSize);
        _currentOffset += newPosts.length;
        emit(PostLoaded(
          currentState.posts + newPosts,
          hasReachedEnd: newPosts.length < _pageSize,
        ));
      } catch (_) {
        emit(PostError());
      }
    }
  }

  Future<void> _onUpdatePost(UpdatePostEvent event, Emitter<PostState> emit) async {
    if (state is PostLoaded) {
      final currentState = state as PostLoaded;

      final updatedPosts = currentState.posts.map((post) {
        return post.id == event.updatedPost.id ? event.updatedPost : post;
      }).toList();

      emit(PostLoaded(updatedPosts, hasReachedEnd: currentState.hasReachedEnd));

      final result = await updatePostUsecase(event.updatedPost);

      if (result.isFailure) {
        emit(PostError());
      }
    }
  }


  Future<void> _onDeletePost(DeletePostEvent event, Emitter<PostState> emit) async {
    if (state is PostLoaded) {
      final currentState = state as PostLoaded;

      emit(PostDeleting());

      try {
        await deletePostUseCase(event.postId);
        final updatedPosts =
        currentState.posts.where((p) => p.id != event.postId).toList();
        emit(PostDeleteSuccess());
        emit(PostLoaded(updatedPosts, hasReachedEnd: currentState.hasReachedEnd));
      } catch (_) {
        emit(PostDeleteError());
      }
    }
  }

}