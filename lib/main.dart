import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_event.dart';
import 'package:pixelmonworldsweb/pages/landing_screen.dart';

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
          builder: (context, state) => const LandingScreen(),
        ),
      ],
    );

    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthCheckPersistedLogin()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pixelmon Worlds',
        routerConfig: router,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.red,
          fontFamily: 'PressStart2P',
        ),
      ),
    );
  }
}
