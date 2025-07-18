abstract class RegisterEvent {}

class RegisterRequested extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  RegisterRequested({
    required this.username,
    required this.email,
    required this.password,
  });
}
