import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_event.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_state.dart';
import 'package:pixelmonworldsweb/widgets/buttons/animated_button.dart';
import 'package:pixelmonworldsweb/widgets/dialogs/login_dialog.dart';
import 'package:pixelmonworldsweb/widgets/dialogs/register_dialog.dart';
import 'package:pixelmonworldsweb/widgets/player_head.dart';

class LoginRegisterButtons extends StatelessWidget {
  const LoginRegisterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final username = state.username;

          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: PlayerHead(username: username),
              ),
              const SizedBox(width: 16),
              Text(username),
              const SizedBox(width: 16),
              AnimatedButton(
                label: 'Deslogar',
                filled: true,
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
              ),
            ],
          );
        }

        return Row(
          children: [
            AnimatedButton(
              label: 'Entrar',
              filled: true,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const LoginDialog(),
                );
              },
            ),
            const SizedBox(width: 16),
            AnimatedButton(
              label: 'Registrar',
              filled: false,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const RegisterDialog(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
