import 'package:afarscape/features/features/posts/presentation/widgets/create_post_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/post_item.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.status == PostStatus.success) {
            context.read<PostBloc>().add(LoadPosts());
          } else if (state.status == PostStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.deleting ||
              state.status == PostStatus.creating ||
              state.status == PostStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.error) {
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
          } else if (state.status == PostStatus.loaded) {
            final filteredPosts = state.posts.where((post) {
              return post.title
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
            }).toList();

            return CustomScrollView(
              slivers: [
                CustomAppBar(
                  onSearchChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  onSearchCancelled: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                ),
                if (filteredPosts.isEmpty)
                  SliverFillRemaining(
                    child: _buildNoResultsMessage(),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final post = filteredPosts[index];
                        return PostItem(post: post);
                      },
                      childCount: filteredPosts.length,
                    ),
                  ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoResultsMessage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No posts found. Try a different search term.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
              });
            },
            child: const Text('Reset Search'),
          ),
        ],
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
