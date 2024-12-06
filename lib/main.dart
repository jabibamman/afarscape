import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/features/posts/presentation/app_router.dart';
import 'features/features/posts/presentation/blocs/post_bloc/post_bloc.dart';
import 'features/features/posts/presentation/blocs/post_bloc/post_event.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const Afarscape());
}

class Afarscape extends StatelessWidget {
  const Afarscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PostBloc>()..add(LoadPosts()),
      child: MaterialApp(
        title: 'Afarscape',
        theme: DjiboutiTheme.lightTheme,
        darkTheme: DjiboutiTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRouter.postList,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}