import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import '../screens/post_detail_screen.dart';
import '../widgets/delete_confirmation_dialog.dart';
import '../widgets/edit_post_dialog.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(post.id),
      background: _buildEditBackground(),
      secondaryBackground: _buildDeleteBackground(),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await _showEditDialog(context, post);
          return false;
        } else if (direction == DismissDirection.endToStart) {
          return await _confirmDelete(context, post);
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        child: Card(
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: const Icon(
              Icons.place,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.blue,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, Post post) async {
    showDialog(
      context: context,
      builder: (context) => EditPostDialog(post: post),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, Post post) async {
    return await showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        onDelete: () {
          context.read<PostBloc>().add(DeletePostEvent(post.id));
        },
      ),
    ) ?? false;
  }
}
