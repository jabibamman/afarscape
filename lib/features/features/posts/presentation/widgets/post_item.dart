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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: post.imageUrl != null
                      ? Image.network(
                    post.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderImage(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                      : _buildPlaceholderImage(),
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
                  subtitle: Text(
                    _buildSubtitle(post.description),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
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

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: 40,
      ),
    );
  }

  String _buildSubtitle(String description) {
    if (description.isEmpty) {
      return "No description available";
    }
    const int maxWords = 10;
    final words = description.split(' ');
    if (words.length <= maxWords) {
      return description;
    }
    return words.sublist(0, maxWords).join(' ') + '...';
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
