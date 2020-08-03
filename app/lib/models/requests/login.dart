
class LoginRequest {

  String usuario;
  String contrasena;

  Map<String, dynamic> toJson() =>
    {
      'usuario': usuario,
      'contrasena': contrasena,
    };
}