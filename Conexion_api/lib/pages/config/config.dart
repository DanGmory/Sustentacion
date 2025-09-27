import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _darkTheme = false;
  String _selectedLanguage = 'Español';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),
          const Text(
            "Cuenta",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),

          // Cambiar Email
          _buildConfigTile(
            icon: Icons.email,
            title: "Cambiar Email",
            subtitle: "Actualiza tu dirección de correo electrónico",
            onTap: () {
              // Aquí navegas a una pantalla de cambio de correo
            },
          ),

          // Cambiar Contraseña
          _buildConfigTile(
            icon: Icons.lock,
            title: "Cambiar Contraseña",
            subtitle: "Establece una nueva contraseña segura",
            onTap: () {
              // Aquí navegas a una pantalla de cambio de contraseña
            },
          ),

          const SizedBox(height: 20),
          const Text(
            "Apariencia",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),

          // Tema
          _buildConfigTile(
            icon: Icons.color_lens,
            title: "Tema de la App",
            subtitle: "Personaliza colores y aspecto",
            onTap: () {
              setState(() {
                _darkTheme = !_darkTheme;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _darkTheme ? "Modo oscuro activado" : "Modo claro activado",
                  ),
                ),
              );
            },
          ),

          // Idioma
          _buildConfigTile(
            icon: Icons.language,
            title: "Idioma",
            subtitle: "Selecciona el idioma de la aplicación",
            onTap: () {
              _showLanguageDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfigTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[700], size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Seleccionar idioma"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: "Español",
                groupValue: _selectedLanguage,
                title: const Text("Español"),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                value: "Inglés",
                groupValue: _selectedLanguage,
                title: const Text("Inglés"),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
