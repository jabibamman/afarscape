import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/features/posts/presentation/blocs/post_bloc.dart';
import 'features/features/posts/presentation/pages/post_list_page.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const Afarscape());
}

class Afarscape extends StatelessWidget {
  const Afarscape({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afarscape',
      theme: DjiboutiTheme.lightTheme,
      home: BlocProvider(
        create: (_) => sl<PostBloc>()..add(LoadPosts()),
        child: const PostListPage(),
      ),
    );
  }
}

