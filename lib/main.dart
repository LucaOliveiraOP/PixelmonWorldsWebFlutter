import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_event.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_bloc.dart';
import 'package:pixelmonworldsweb/pages/dashboard_page.dart';
import 'package:pixelmonworldsweb/pages/dyn_map_page.dart';
import 'package:pixelmonworldsweb/widgets/nav_and_footer.dart';
import 'package:pixelmonworldsweb/pages/landing_screen.dart';
import 'package:pixelmonworldsweb/pages/store_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => _buildTransitionPage(
            key: state.pageKey,
            child: const NavAndFooter(child: LandingScreen()),
          ),
        ),
        GoRoute(
          path: '/loja',
          pageBuilder: (context, state) => _buildTransitionPage(
            key: state.pageKey,
            child: const NavAndFooter(child: StorePage()),
          ),
        ),
        GoRoute(
          path: '/mapa',
          pageBuilder: (context, state) => _buildTransitionPage(
            key: state.pageKey,
            child: const NavAndFooter(child: DynmapPage()),
          ),
        ),
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => _buildTransitionPage(
            key: state.pageKey,
            child: NavAndFooter(child: const DashBoardPage(playerData: {})),
          ),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthCheckPersistedLogin()),
        ),
        BlocProvider(
          create: (context) => StoreBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pixelmon Worlds',
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF1E1E1E),
          primaryColor: Colors.red,
          fontFamily: 'PressStart2P',
        ),
      ),
    );
  }
}

CustomTransitionPage _buildTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeTween = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeInOut));

      return FadeTransition(
        opacity: animation.drive(fadeTween),
        child: child,
      );
    },
  );
}
