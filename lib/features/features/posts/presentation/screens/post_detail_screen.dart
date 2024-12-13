import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/post_detail_content.dart';
import '../widgets/edit_post_dialog.dart';
import '../widgets/delete_confirmation_dialog.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.status == PostStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          } else if (state.status == PostStatus.deleting) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          Post currentPost = post;

          if (state.posts.isNotEmpty) {
            final updatedPost = state.posts.firstWhere(
                  (p) => p.id == post.id,
              orElse: () => post,
            );
            currentPost = updatedPost;
          }

          if (state.status == PostStatus.deleting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              const CustomAppBar(
                showBackButton: true,
                showSearching: false,
              ),
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
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  Widget _buildFloatingActionButtons(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        Post currentPost = post;

        if (state.posts.isNotEmpty) {
          final updatedPost = state.posts.firstWhere(
                (p) => p.id == post.id,
            orElse: () => post,
          );
          currentPost = updatedPost;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'edit',
              onPressed: () => _showEditDialog(context, currentPost),
              child: const Icon(Icons.edit),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: 'delete',
              onPressed: () => _confirmDelete(context, currentPost),
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => EditPostDialog(post: post),
    );
  }

  void _confirmDelete(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        onDelete: () {
          context.read<PostBloc>().add(DeletePostEvent(post.id));
        },
      ),
    );
  }
}
