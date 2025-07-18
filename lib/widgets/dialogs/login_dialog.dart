import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_bloc.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_event.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_state.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Autenticado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.catching_pokemon_rounded, color: Colors.red, size: 36),
              SizedBox(width: 16),
              Text('Entrar'),
              SizedBox(width: 16),
              Icon(Icons.catching_pokemon, color: Colors.red, size: 36),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _userController,
                decoration: const InputDecoration(labelText: 'Login'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              if (state is AuthLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     final uuid = _userController.text.trim();
            //     // envia o evento mesmo se estiver vazio
            //     context.read<AuthBloc>().add(AuthLoginRequested(uuid));
            //   },
            //   child: const Text('Entrar'),
            // ),
            //correto porem o acima é para testes
            ElevatedButton(
              onPressed: state is AuthLoading
                  ? null
                  : () {
                      final username = _userController.text.trim();
                      final password = _passwordController.text.trim();

                      if (username.isNotEmpty && password.isNotEmpty) {
                        context
                            .read<AuthBloc>()
                            .add(AuthLoginRequested(username, password));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Algum campo está vazio ?'),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        );
                      }
                    },
              child: const Text('Entrar'),
            ),
          ],
        );
      },
    );
  }
}
