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
          if (state.status == PostStatus.success) {
            Navigator.of(context).pop();
          } else if (state.status == PostStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PostStatus.deleting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Post currentPost = post;
          if (state.status == PostStatus.success) {
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'edit',
            onPressed: () => _showEditDialog(context, post),
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'delete',
            onPressed: () => _confirmDelete(context, post),
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
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
