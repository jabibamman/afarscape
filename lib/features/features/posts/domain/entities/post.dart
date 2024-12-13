class Post {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final bool isFavorite;

  const Post({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.isFavorite = false,
  });

  Post copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
