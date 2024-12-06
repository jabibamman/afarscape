import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
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
        ),
        leading: const Icon(
          Icons.place,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
