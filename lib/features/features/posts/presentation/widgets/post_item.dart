import 'package:afarscape/features/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
