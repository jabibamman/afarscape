import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_event.dart';
import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_state.dart';

import '../../../domain/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  static const int _pageSize = 10;
  int _currentOffset = 0;

  PostBloc({required this.repository}) : super(PostLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadMorePosts>(_onLoadMorePosts);
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
}