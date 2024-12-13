import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/post_item.dart';
import '../widgets/create_post_dialog.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String _searchQuery = '';
  bool _showFavorites = false;

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
          SliverToBoxAdapter(
            child: _buildTabSwitcher(),
          ),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state.status == PostStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.status == PostStatus.error) {
                return SliverFillRemaining(
                  child: Center(
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
                  ),
                );
              }

              final allPosts = state.posts;
              final favoritePosts = state.posts.where((post) => post.isFavorite).toList();
              final postsToShow = _showFavorites ? favoritePosts : allPosts;
              final filteredPosts = _getFilteredPosts(postsToShow);

              if (filteredPosts.isEmpty) {
                return SliverFillRemaining(
                  child: _buildNoResultsMessage(),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final post = filteredPosts[index];
                    return PostItem(
                        key: ValueKey(post.id),
                        post: post);
                  },
                  childCount: filteredPosts.length,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton('All Posts', !_showFavorites),
          _buildTabButton('Favorites', _showFavorites),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showFavorites = (title == 'Favorites');
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<Post> _getFilteredPosts(List<Post> posts) {
    return posts.where((post) {
      return post.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
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
