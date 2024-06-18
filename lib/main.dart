import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobis/remote/financial_institution_repository.dart';
import 'package:mobis/screens/dashboard_screen/dashboard_screen.dart';
import 'package:mobis/screens/dashboard_screen/dashboard_screen_cubit.dart';
import 'package:mobis/screens/login_error_screen/login_error_screen.dart';
import 'package:mobis/screens/login_screen/login_screen.dart';
import 'package:mobis/screens/login_screen/login_screen_cubit.dart';
import 'package:mobis/screens/welcome_screen/welcome_screen.dart';
import 'package:mobis/storage/user_shared_preference_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    RepositoryProvider(
      create: (BuildContext context) =>
          UserSharedPreferenceRepository(sharedPreferences: prefs),
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: DashboardScreen.path,
        builder: (BuildContext context, GoRouterState state) {
          return RepositoryProvider(
            create: (context) => FinancialInstitutionRepository(),
            child: BlocProvider(
              create: (context) => DashboardScreenCubit(context.read()),
              child: const DashboardScreen(),
            ),
          );
        },
        routes: const <RouteBase>[],
        redirect: (BuildContext context, GoRouterState state) {
          final phoneNumber = context.getUserPrefsRepository().getPhoneNumber();

          return phoneNumber.isNotEmpty ? null : WelcomeScreen.path;
        }),
    GoRoute(
      path: WelcomeScreen.path,
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: LoginScreen.path,
          builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return LoginScreenCubit(
                context.getUserPrefsRepository(),
              );
            },
            child: const LoginScreen(),
          ),
          routes: [
            GoRoute(
              path: LoginErrorScreen.path,
              builder: (context, state) => const LoginErrorScreen(),
            ),
          ],
        ),
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
