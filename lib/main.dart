import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobis/authentication/authentication_repository.dart';
import 'package:mobis/models/financial_institution.dart';
import 'package:mobis/provider/database_provider.dart';
import 'package:mobis/provider/financial_institution_provider.dart';
import 'package:mobis/provider/transaction_provider.dart';
import 'package:mobis/remote/financial_institution_repository.dart';
import 'package:mobis/screens/dashboard_screen/dashboard_screen.dart';
import 'package:mobis/screens/dashboard_screen/dashboard_screen_cubit.dart';
import 'package:mobis/screens/institution_details_screen/institution_details_screen.dart';
import 'package:mobis/screens/login_error_screen/login_error_screen.dart';
import 'package:mobis/screens/login_screen/login_screen.dart';
import 'package:mobis/screens/login_screen/login_screen_cubit.dart';
import 'package:mobis/screens/signup_error_screen/signup_error_screen.dart';
import 'package:mobis/screens/signup_screen/signup_screen.dart';
import 'package:mobis/screens/signup_screen/signup_screen_cubit.dart';
import 'package:mobis/screens/welcome_screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var rootToken = RootIsolateToken.instance!;
  final items = await compute((rootToken) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);

    return (await Future.wait(
        [DatabaseProvider.initialDatabase(), SharedPreferences.getInstance()]));
  }, rootToken);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => items.first as Database),
        RepositoryProvider(
          create: (context) => TransactionProvider(
            db: context.read(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FinancialInstitutionProvider(
            transactionProvider: context.read(),
            db: context.read(),
          ),
        ),
        RepositoryProvider(
          create: (BuildContext context) => AuthenticationRepository(
            sharedPreferences: items.last as SharedPreferences,
            financialInstitutionProvider: context.read(),
            transactionProvider: context.read(),
          ),
        ),
      ],
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
            create: (context) => FinancialInstitutionRepository(
              financialInstitutionProvider: context.read(),
              authenticationRepository: context.read(),
            ),
            child: BlocProvider(
              create: (context) => DashboardScreenCubit(context.read()),
              child: const DashboardScreen(),
            ),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: InstitutionDetailsScreen.path,
            builder: (context, state) {
              final institution = state.extra as FinancialInstitution;
              return InstitutionDetailsScreen(
                financialInstitution: institution,
              );
            },
          ),
        ],
        redirect: (BuildContext context, GoRouterState state) {
          final phoneNumber =
              context.getAuthenticationRepository().getPhoneNumber();

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
                context.getAuthenticationRepository(),
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
        GoRoute(
          path: SignupScreen.path,
          builder: (context, state) => BlocProvider(
            child: const SignupScreen(),
            create: (BuildContext context) {
              return SignupScreenCubit(
                context.getAuthenticationRepository(),
              );
            },
          ),
          routes: [
            GoRoute(
              path: SignupErrorScreen.path,
              builder: (context, state) => const SignupErrorScreen(),
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
