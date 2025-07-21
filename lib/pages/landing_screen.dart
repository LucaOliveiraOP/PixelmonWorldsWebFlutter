import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_state.dart';
import 'package:pixelmonworldsweb/widgets/landing_page_footer.dart';
import 'package:pixelmonworldsweb/widgets/landing_page_nav_bar.dart';
import 'landing_page.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.redAccent;
            }
            return Colors.red;
          }),
          thickness: MaterialStateProperty.all(8),
          radius: const Radius.circular(8),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            primary: true,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.7))),
                Column(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return LandingPage(authState: state);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
