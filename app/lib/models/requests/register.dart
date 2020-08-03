

class RegisterRequest {

  String usuario;
  String contrasena;
  String email;
  List<String> preferencias;

  RegisterRequest() {
    preferencias = List<String>();
  }

  Map<String, dynamic> toJson() =>
      {
        'usuario': usuario,
        'contrasena': contrasena,
        'email': email,
        'preferencias': preferencias
      };
}