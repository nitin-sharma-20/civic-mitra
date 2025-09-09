import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_colors.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_page.dart';
import 'features/report/presentation/bloc/report_bloc.dart';
import 'features/report/presentation/pages/home_page.dart';
import 'features/report/presentation/pages/new_report_page.dart';
import 'features/report/presentation/pages/report_details_page.dart';
import 'features/report/domain/entity/report.dart';
import 'injection_container.dart';

class CitizenSafetyApp extends StatelessWidget {
  const CitizenSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<ReportBloc>(
          create: (context) => sl<ReportBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'RaastaFix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.green,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final phoneNumber = state.extra as String;
        return OtpPage(phoneNumber: phoneNumber);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/new-report',
      builder: (context, state) => const NewReportPage(),
    ),
    GoRoute(
      path: '/report-details/:reportId',
      builder: (context, state) {
        // In a real app, you'd fetch the report by ID
        // For now, we'll pass the report as extra data
        final report = state.extra as Report;
        return ReportDetailsPage(report: report);
      },
    ),
  ],
  redirect: (context, state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    
    final isOnAuthPages = ['/login', '/otp'].contains(state.matchedLocation);
    final isOnSplash = state.matchedLocation == '/';
    
    if (authState is AuthAuthenticated) {
      if (isOnAuthPages || isOnSplash) {
        return '/home';
      }
    } else if (authState is AuthUnauthenticated) {
      if (!isOnAuthPages && !isOnSplash) {
        return '/login';
      }
    }
    
    return null;
  },
);