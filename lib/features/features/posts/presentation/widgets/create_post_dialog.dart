import 'package:flutter/material.dart';
import '../../../../../core/utils/validation_utils.dart';
import '../../domain/entities/post.dart';

class CreatePostDialog extends StatefulWidget {
  final void Function(Post) onCreatePost;

  const CreatePostDialog({super.key, required this.onCreatePost});

  @override
  CreatePostDialogState createState() => CreatePostDialogState();
}

class CreatePostDialogState extends State<CreatePostDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  void _onAddPost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        imageUrl: imageUrlController.text.isNotEmpty ? imageUrlController.text.trim() : null,
      );

      widget.onCreatePost(newPost);
      Navigator.of(context).pop();
    } else {
      setState(() {
        errorMessage = 'Please fix the errors in the form.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Post'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title*'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value != null && value.isNotEmpty && !_isValidUrl(value)) {
                    return 'Please enter a valid URL.';
                  }
                  return null;
                },
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _onAddPost,
          child: const Text('Add'),
        ),
      ],
    );
  }

  bool _isValidUrl(String value) {
    return UrlValidator.isValid(value);
  }
}
