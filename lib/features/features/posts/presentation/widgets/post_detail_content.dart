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
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
