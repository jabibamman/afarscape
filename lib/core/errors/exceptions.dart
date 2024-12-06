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
