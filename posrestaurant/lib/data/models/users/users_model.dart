class User {
  final int? id;
  final String nombreCompleto;
  final String username;
  final String contrasena; // Hash
  final String rol;
  final String status;
  final String pinCobro; // Hash
  final String? telefono;
  User({
    this.id,
    required this.nombreCompleto,
    required this.username,
    required this.contrasena,
    required this.rol,
    required this.status,
    required this.pinCobro,
    this.telefono,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre_completo': nombreCompleto,
      'username': username,
      'contrasena': contrasena,
      'rol': rol,
      'status': status,
      'pin_cobro': pinCobro,
      'telefono': telefono,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nombreCompleto: map['nombre_completo'],
      username: map['username'],
      contrasena: map['contrasena'],
      rol: map['rol'],
      status: map['status'],
      pinCobro: map['pin_cobro'],
      telefono: map['telefono'],
    );
  }
}