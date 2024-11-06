import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'redirect.g.dart';

@riverpod
class AuthRedirect extends _$AuthRedirect {
  @override
  bool build() {
    return false; // Default to not authenticated
  }

  void setAuthenticated(bool value) {
    state = value;
  }
}

String? authRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
  final isAuthenticated = ref.watch(authRedirectProvider);
  
  // Define auth routes that should be accessible without authentication
  final isAuthRoute = state.matchedLocation == '/login' ||
                     state.matchedLocation == '/otp' ||
                     state.matchedLocation == '/name_and_email' ||
                     state.matchedLocation == '/splash' ||
                     state.matchedLocation == '/onboarding';

  // If user is not authenticated and tries to access protected route
  if (!isAuthenticated && !isAuthRoute) {
    return '/login';
  }

  // If user is authenticated and tries to access auth routes
  if (isAuthenticated && isAuthRoute && state.matchedLocation != '/splash' && state.matchedLocation != '/onboarding') {
    return '/';
  }

  return null;
}
