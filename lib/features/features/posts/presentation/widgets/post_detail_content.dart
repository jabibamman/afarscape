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
                  image: DecorationImage(
                    image: NetworkImage(post.imageUrl!),
                    fit: BoxFit.cover,
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
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  post.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: post.isFavorite ? Colors.red : Colors.grey,
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
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
