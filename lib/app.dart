import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hola_todo/core/di/di.dart';
import 'package:hola_todo/core/utils/theme.dart';
import 'package:hola_todo/presentation/mobx/tag/tag_store.dart';
import 'package:hola_todo/presentation/mobx/task/tasks_store.dart';
import 'package:hola_todo/presentation/router.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return MultiProvider(
      providers: [
        Provider(create: (context) => getIt.get<TasksStore>()),
        Provider(create: (context) => getIt.get<TagStore>()),
      ],
      child: MaterialApp.router(
        title: 'Hola Todo',
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme:
              GoogleFonts.ubuntuTextTheme(baseTheme.textTheme).copyWith(),
          appBarTheme: AppBarTheme(backgroundColor: backgroundColor),
        ),
        routerConfig: router,
      ),
    );
  }
}
