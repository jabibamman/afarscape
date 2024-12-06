import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_event.dart';
import 'package:afarscape/features/features/posts/presentation/blocs/post_bloc/post_state.dart';

import '../../../domain/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
