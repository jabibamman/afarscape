import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

class PostDetailContent extends StatelessWidget {
  final Post post;

  const PostDetailContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (post.imageUrl != null)
            GestureDetector(
              onTap: () => _showImageDialog(context, post.imageUrl!),
              child: Container(
                height: 250,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(post.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            post.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
