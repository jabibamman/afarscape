class PostNotFoundException implements Exception {
  final String message;

  PostNotFoundException([this.message = 'Post not found.']);

  @override
  String toString() => 'PostNotFoundException: $message';
}

class UnimplementedFeatureException implements Exception {
  final String featureName;

  UnimplementedFeatureException([this.featureName = 'Unknown feature']);

  @override
  String toString() => 'UnimplementedFeatureException: $featureName is not implemented.';
}

class InvalidPostException implements Exception {
  final String message;

  InvalidPostException([this.message = 'Invalid post.']);

  @override
  String toString() => message;
}