// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/database/app_database.dart' as _i160;
import '../../data/repositories/tag_repository.dart' as _i811;
import '../../data/repositories/task_repository.dart' as _i515;
import '../../presentation/mobx/tag/tag_store.dart' as _i660;
import '../../presentation/mobx/task/tasks_store.dart' as _i767;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i515.TaskRepository>(
      () => _i515.TaskRepository(gh<_i160.AppDatabase>()));
  gh.factory<_i811.TagRepository>(
      () => _i811.TagRepository(gh<_i160.AppDatabase>()));
  gh.factory<_i660.TagStore>(() => _i660.TagStore(gh<_i811.TagRepository>()));
  gh.factory<_i767.TasksStore>(
      () => _i767.TasksStore(gh<_i515.TaskRepository>()));
  return getIt;
}
