import 'package:flutter/material.dart';
import '../domain/entities/post.dart';
import 'screens/post_list_screen.dart';
import 'screens/post_detail_screen.dart';

class AppRouter {
  static const String postList = '/';
  static const String postDetail = '/postDetail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case postList:
        return MaterialPageRoute(
          builder: (_) => const PostListPage(),
        );
      case postDetail:
        if (settings.arguments is Post) {
          final post = settings.arguments as Post;
          return MaterialPageRoute(
            builder: (_) => PostDetailScreen(post: post),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
