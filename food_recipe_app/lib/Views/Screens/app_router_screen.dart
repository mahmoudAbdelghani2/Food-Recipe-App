import 'package:cooking_app/Views/Screens/profile_screen.dart';
import 'package:cooking_app/Views/Screens/recipe_detail_screen.dart';
import 'package:cooking_app/Views/Screens/signin_screen.dart';
import 'package:cooking_app/Views/Screens/signup_screen.dart';
import 'package:cooking_app/Views/Screens/splash_screen.dart';

import 'package:cooking_app/Views/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final ValueNotifier<bool?> authState = ValueNotifier<bool?>(null);

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: authState,
    redirect: (context, state) {
      final isLoggedIn = authState.value;

      if (isLoggedIn == null) return null;

      if (isLoggedIn &&
          (state.matchedLocation == '/splash' ||
              state.matchedLocation == '/login' ||
              state.matchedLocation == '/register')) {
        return '/home';
      }

      if (!isLoggedIn && state.matchedLocation == '/home') {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/recipe/:id',
        builder: (context, state) {
          final recipe = state.extra as Map<String, dynamic>? ?? {};
          final recipeId = state.pathParameters['id'] ?? '1';
          return RecipeDetailScreen(
            recipeData: recipe,
            recipeId: recipeId,
          );
        },
      ),
    ],
  );
}
