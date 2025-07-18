abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String username;
  final Map<String, dynamic> playerData;
  AuthSuccess(this.playerData, this.username);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
