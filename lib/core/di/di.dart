
import 'package:get_it/get_it.dart';
import 'package:hola_todo/core/di/di.config.dart';
import 'package:hola_todo/data/database/app_database.dart';
import 'package:injectable/injectable.dart';


final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  $initGetIt(getIt);
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);
}
