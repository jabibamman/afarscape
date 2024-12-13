import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';

class EditPostDialog extends StatelessWidget {
  final Post post;

  const EditPostDialog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: post.title);
    final TextEditingController descriptionController =
    TextEditingController(text: post.description);
    final TextEditingController imageUrlController =
    TextEditingController(text: post.imageUrl);

    return AlertDialog(
      title: const Text('Edit Post'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedPost = Post(
              id: post.id,
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              imageUrl: imageUrlController.text.trim(),
            );

            context.read<PostBloc>().add(UpdatePostEvent(updatedPost));

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
