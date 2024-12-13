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
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  image: post.imageUrl != null
                      ? DecorationImage(
                    image: NetworkImage(post.imageUrl!),
                    fit: BoxFit.cover,
                  )
                      : const DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text(
                    'Tap to see details',
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      post.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: post.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      context.read<PostBloc>().add(ToggleFavoriteEvent(post.id));
                    },
                  ),
                ),
              ),
            ],
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
    ) ??
        false;
  }
}
