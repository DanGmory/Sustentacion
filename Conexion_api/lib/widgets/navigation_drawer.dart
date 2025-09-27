import 'package:flutter/material.dart';
import '../pages/common/underConstruction.dart';

class CustomDrawer extends StatelessWidget {
  final String username;
  final Function(int) onItemSelected;
  final VoidCallback onLogout;
  final int currentIndex;

  const CustomDrawer({
    super.key,
    required this.username,
    required this.onItemSelected,
    required this.onLogout,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(context),
          _buildMenuItems(context, theme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: theme.colorScheme.onPrimary,
            child: Icon(
              Icons.person,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            username,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'usuario@demo.com',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        _buildListTile(
          context,
          Icons.home,
          'Inicio',
          0,
          currentIndex == 0,
        ),
        _buildListTile(
          context,
          Icons.person,
          'Mi Perfil',
          1,
          currentIndex == 1,
        ),
        _buildListTile(
          context,
          Icons.settings,
          'Configuración',
          2,
          currentIndex == 2,
        ),
        _buildListTile(
          context,
          Icons.pets,
          'Pokemons',
          3,
          currentIndex == 3,
        ),
        const Divider(),

        // 👉 Pantallas en construcción (sin const)
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notificaciones'),
          onTap: () {
            Navigator.pop(context); // Cierra el drawer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UnderConstructionScreen(title: "Notificaciones"),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Ayuda'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UnderConstructionScreen(title: "Ayuda"),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Acerca de'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UnderConstructionScreen(title: "Acerca de"),
              ),
            );
          },
        ),
        const Divider(),
        _buildLogoutTile(context),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context,
    IconData icon,
    String title,
    int index,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.colorScheme.primary : theme.iconTheme.color,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.textTheme.bodyMedium?.color,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.arrow_forward,
              color: theme.colorScheme.primary,
              size: 20,
            )
          : null,
      onTap: () => onItemSelected(index),
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: Text(
        'Cerrar Sesión',
        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
      ),
      onTap: () {
        Navigator.pop(context); // Cierra el Drawer
        onLogout();
      },
    );
  }
}
