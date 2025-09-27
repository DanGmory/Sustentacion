class Validators {
  /// 🔹 Valida que el texto sea un correo electrónico válido
  static String? validateEmail(String? value) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo electrónico';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null; // ✅ válido
  }

  /// 🔹 Valida que la contraseña cumpla con las reglas:
  /// - 8 a 16 caracteres
  /// - Al menos un dígito
  /// - Una minúscula
  /// - Una mayúscula
  /// - Un carácter especial
  static String? validatePassword(String? value) {
    final RegExp passwordRegExp =
        RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{8,16}$');

    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'La contraseña debe tener:\n'
          '- 8 a 16 caracteres\n'
          '- Al menos un dígito\n'
          '- Una minúscula\n'
          '- Una mayúscula\n'
          '- Un carácter especial';
    }
    return null; // ✅ válido
  }
}
