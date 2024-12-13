import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import 'image_viewer.dart';

class PostDetailContent extends StatelessWidget {
  final Post post;

  const PostDetailContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (post.imageUrl != null)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageViewer(imageUrl: post.imageUrl!),
                  ),
                );
              },
              child: Container(
                height: 250,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    post.imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderImage();
                    },
                  ),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  post.title,
                  style: textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: Icon(
                  post.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: post.isFavorite
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                onPressed: () {
                  context.read<PostBloc>().add(ToggleFavoriteEvent(post.id));
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            post.description,
            style: textTheme.bodyMedium,
          ),
        ],
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
        size: 50,
      ),
    );
  }
}
