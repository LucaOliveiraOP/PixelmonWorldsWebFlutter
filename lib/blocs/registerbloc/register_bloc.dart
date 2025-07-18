import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pixelmonworldsweb/blocs/registerbloc/register_event.dart';
import 'package:pixelmonworldsweb/blocs/registerbloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final res = await http.post(
        Uri.parse('http://localhost:3000/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': event.username,
          'email': event.email,
          'password': event.password,
        }),
      );

      if (res.statusCode == 200) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure("Erro ao registrar"));
      }
    } catch (e) {
      emit(RegisterFailure("Erro de conexão"));
    }
  }
}
