// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthInitial()) {
//     on<AuthLoginRequested>(_onLogin);
//     on<AuthLogoutRequested>((event, emit) {
//       emit(AuthInitial());
//     });
//   }

//   Future<void> _onLogin(
//       AuthLoginRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final res = await http.post(
//         Uri.parse('http://localhost:3000/auth/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'uuid': event.uuid}),
//       );

//       if (res.statusCode == 200) {
//         final player = jsonDecode(res.body);
//         emit(AuthSuccess(player));
//       } else {
//         emit(AuthFailure("UUID inválido ou erro de login"));
//       }
//     } catch (e) {
//       emit(AuthFailure("Erro de conexão"));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthCheckPersistedLogin>(_onCheckPersistedLogin);
    _checkLoginOnStart();
  }

  Future<void> _onLogin(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 1));

    if (event.username == 'zBlackFire' && event.password == '123') {
      final playerData = {
        'username': 'zBlackFire',
        'uuid': 'local-uuid-1234',
      };

      // Persistir login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', event.username);

      emit(AuthSuccess(playerData, event.username));
    } else {
      emit(AuthFailure('Usuário ou senha inválidos'));
    }
  }

  Future<void> _onLogout(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    emit(AuthInitial());
  }

  Future<void> _onCheckPersistedLogin(
      AuthCheckPersistedLogin event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username != null) {
      final playerData = {
        'username': username,
        'uuid': 'local-uuid-1234',
      };
      emit(AuthSuccess(playerData, username));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _checkLoginOnStart() async {
    add(AuthCheckPersistedLogin());
  }
}
