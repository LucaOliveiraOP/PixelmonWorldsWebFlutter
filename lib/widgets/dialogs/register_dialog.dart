// lib/widgets/register_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelmonworldsweb/blocs/registerbloc/register_bloc.dart';
import 'package:pixelmonworldsweb/blocs/registerbloc/register_event.dart';
import 'package:pixelmonworldsweb/blocs/registerbloc/register_state.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registrado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.catching_pokemon_rounded,
                    color: Colors.red, size: 36),
                SizedBox(width: 16),
                Text('Registrar'),
                SizedBox(width: 16),
                Icon(Icons.catching_pokemon, color: Colors.red, size: 36),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Usuário'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                ),
                if (state is RegisterLoading)
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
              ElevatedButton(
                onPressed: state is RegisterLoading
                    ? null
                    : () {
                        final username = _usernameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (username.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha todos os campos'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        context.read<RegisterBloc>().add(
                              RegisterRequested(
                                username: username,
                                email: email,
                                password: password,
                              ),
                            );
                      },
                child: const Text('Registrar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
