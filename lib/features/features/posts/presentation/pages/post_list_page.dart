import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/post_item.dart';

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
