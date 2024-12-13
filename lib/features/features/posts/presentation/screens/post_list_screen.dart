import 'package:afarscape/features/features/posts/presentation/widgets/create_post_dialog.dart';
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
    return Scaffold(
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.status == PostStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.success || state.status == PostStatus.loaded) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text(
                  'No posts available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                const CustomAppBar(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final post = state.posts[index];
                      return PostItem(post: post);
                    },
                    childCount: state.posts.length,
                  ),
                ),
              ],
            );
          } else if (state.status == PostStatus.deleting ||
              state.status == PostStatus.creating ||
              state.status == PostStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Failed to load posts.',
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostBloc>().add(LoadPosts());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreatePostDialog(
        onCreatePost: (newPost) {
          context.read<PostBloc>().add(AddPostEvent(newPost));
        },
      ),
    );
  }
}