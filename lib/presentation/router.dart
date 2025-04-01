import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_todo/core/utils/circular_reveal_transition.dart';
import 'package:hola_todo/presentation/screens/add_edit_screen.dart';
import 'package:hola_todo/presentation/screens/home_screen.dart';

const String homeRoute = '/';
const String addRoute = '/add';

final router = GoRouter(
  routes: [
    GoRoute(path: homeRoute, builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: addRoute,
      pageBuilder: (context, state) => CustomCircularRevealPage(
        key: state.pageKey,
        child: const AddEditScreen(),
        position: state.extra as Offset, // Get Fab position
      ),
    ),
  ],
);
