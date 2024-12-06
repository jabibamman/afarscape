import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/post_detail_content.dart';
import '../widgets/edit_post_dialog.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          Post currentPost = post;

          if (state is PostLoaded) {
            currentPost = state.posts.firstWhere(
                  (p) => p.id == post.id,
              orElse: () => post,
            );
          }

          return CustomScrollView(
            slivers: [
              const CustomAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    PostDetailContent(post: currentPost),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(context, post),
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => EditPostDialog(post: post),
    );
  }
}
