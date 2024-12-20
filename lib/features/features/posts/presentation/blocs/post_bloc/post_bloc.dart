import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_event.dart';
import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_state.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_post_use_case.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUsecase updatePostUsecase;
  final CreatePostUseCase createPostUseCase;

  static const int _pageSize = 12;
  int _currentOffset = 0;

  PostBloc({
    required this.createPostUseCase,
    required this.updatePostUsecase,
    required this.deletePostUseCase,
    required this.repository,
  }) : super(const PostState(status: PostStatus.initial)) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<UpdatePostEvent>(_onUpdatePost);
    on<DeletePostEvent>(_onDeletePost);
    on<AddPostEvent>(_onCreatePost);
    on<ToggleFavoriteEvent>(_onToggleFavorite);

  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final postsFromServer = await repository.getPosts();

      final updatedPosts = postsFromServer.map((post) {
        final existingPost = state.posts.firstWhere(
              (p) => p.id == post.id,
          orElse: () => post,
        );
        return post.copyWith(isFavorite: existingPost.isFavorite);
      }).toList();

      emit(state.copyWith(
        status: PostStatus.loaded,
        posts: updatedPosts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostState> emit) async {
    if (state.status != PostStatus.loaded || state.hasReachedEnd) return;

    try {
      final newPosts = await repository.getPaginatedPosts(_currentOffset, _pageSize);
      _currentOffset += newPosts.length;

      emit(state.copyWith(
        posts: [...state.posts, ...newPosts],
        hasReachedEnd: newPosts.length < _pageSize,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Failed to load more posts.',
      ));
    }
  }

  Future<void> _onUpdatePost(UpdatePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.updating));
    try {
      await updatePostUsecase(event.updatedPost);
      final updatedPosts = state.posts.map((post) {
        return post.id == event.updatedPost.id ? event.updatedPost : post;
      }).toList();

      emit(state.copyWith(
        status: PostStatus.loaded,
        posts: updatedPosts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Failed to update Post: $e',
      ));
    }
  }


  Future<void> _onDeletePost(DeletePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.deleting));

    try {
      await deletePostUseCase(event.postId);
      final updatedPosts = state.posts.where((p) => p.id != event.postId).toList();
      emit(state.copyWith(
        status: PostStatus.success,
        posts: updatedPosts,
      ));
      add(LoadPosts());

    } catch (e) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Failed to delete post: $e',
      ));
    }
  }

  Future<void> _onCreatePost(AddPostEvent event, Emitter<PostState> emit) async {
    if (event.newPost.title.trim().isEmpty) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Post title is mandatory.',
      ));
      return;
    }

    emit(state.copyWith(status: PostStatus.creating));

    try {
      await createPostUseCase(event.newPost);

      final updatedPosts = [event.newPost, ...state.posts];
      emit(state.copyWith(
        status: PostStatus.loaded,
        posts: updatedPosts,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: PostStatus.error,
        errorMessage: 'Failed to create post.',
      ));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<PostState> emit) async {
    if (state.status == PostStatus.loaded) {
      final updatedPosts = state.posts.map((post) {
        if (post.id == event.postId) {
          return post.copyWith(isFavorite: !post.isFavorite);
        }
        return post;
      }).toList();

      emit(state.copyWith(posts: updatedPosts));
    }
  }


}