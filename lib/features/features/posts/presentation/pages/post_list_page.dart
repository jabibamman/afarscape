import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_state.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  floating: true,
                  pinned: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: Icon(
                    Icons.travel_explore,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final post = state.posts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            post.description,
                            style: const TextStyle(fontSize: 14),
                          ),
                          leading: const Icon(
                            Icons.place,
                            color: Colors.blueAccent,
                          ),
                        ),
                      );
                    },
                    childCount: state.posts.length,
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
        },
      ),
    );
  }
}
