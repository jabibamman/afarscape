import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/post_item.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    void onScroll() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        context.read<PostBloc>().add(LoadMorePosts());
      }
    }

    scrollController.addListener(onScroll);
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return const Center(
                  child: Text(
                    'No posts available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  const CustomAppBar(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (index >= state.posts.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final post = state.posts[index];
                        return PostItem(post: post);
                      },
                      childCount: state.hasReachedEnd
                          ? state.posts.length
                          : state.posts.length + 1,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'Failed to load posts.',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPost');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}