import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobis/screens/dashboard_screen/dashboard_screen.dart';
import 'package:mobis/screens/login_error_screen/login_error_screen.dart';
import 'package:mobis/screens/login_screen/login_screen.dart';
import 'package:mobis/screens/welcome_screen/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: DashboardScreen.path,
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
        routes: const <RouteBase>[],
        redirect: (BuildContext context, GoRouterState state) {
          return WelcomeScreen.path;
        }),
    GoRoute(
      path: WelcomeScreen.path,
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: LoginScreen.path,
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                path: LoginErrorScreen.path,
                builder: (context, state) => const LoginErrorScreen(),
              ),
            ]),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}
