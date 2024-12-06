import 'package:get_it/get_it.dart';

import 'features/features/posts/data/datasources/fake_post_datasource.dart';
import 'features/features/posts/data/repositories/post_repository_impl.dart';
import 'features/features/posts/domain/repositories/post_repository.dart';
import 'features/features/posts/presentation/blocs/post_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FakePostDataSource());
  sl.registerLazySingleton<PostRepository>(
          () => PostRepositoryImpl(dataSource: sl()));
  sl.registerFactory(() => PostBloc(repository: sl()));
}