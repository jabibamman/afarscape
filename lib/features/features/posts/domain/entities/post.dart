class Post {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;

  const Post({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });
}
