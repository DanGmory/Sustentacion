import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navigation_drawer.dart';
import '../../widgets/navigation_bottom.dart';
import '../user/user.dart';
import '../auth/login.dart';
import '../config/config.dart';
import '../pokemons/pokescreen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  const HomeScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<_FeaturePage> _features;

  @override
  void initState() {
    super.initState();

    // 👇 Lista centralizada de pantallas
    _features = [
      _FeaturePage(
        title: 'Inicio',
        icon: Icons.home,
        page: HomeContent(
          username: widget.username,
          onNavigateTo: (index) => _onFeatureSelected(index),
        ),
      ),
      _FeaturePage(
        title: 'Perfil',
        icon: Icons.person,
        page: UserScreen(
          username: widget.username, 
          password: widget.password),
      ),
      _FeaturePage(
        title: 'Configuración',
        icon: Icons.settings,
        page: const ConfigScreen(),
      ),
      _FeaturePage(
        title: 'Pokemons',
        icon: Icons.pets,
        page: const PokemonScreen(),
      ),
      _FeaturePage(
        title: 'Notificaciones',
        icon: Icons.notifications,
        page: const Center(child: Text('Pantalla de Notificaciones')),
      ),
      _FeaturePage(
        title: 'Ayuda',
        icon: Icons.help,
        page: const Center(child: Text('Pantalla de Ayuda')),
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onFeatureSelected(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: _features[_currentIndex].title,
        showBackButton: false,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: CustomDrawer(
        username: widget.username,
        onItemSelected: _onFeatureSelected,
        onLogout: _logout,
        currentIndex: _currentIndex,
      ),
      body: PageView(
        controller: _pageController,
        children: _features.map((f) => f.page).toList(),
        onPageChanged: (index) => setState(() => _currentIndex = index),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onFeatureSelected,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}

class HomeContent extends StatelessWidget {
  final String username;
  final ValueChanged<int> onNavigateTo;

  const HomeContent({
    super.key,
    required this.username,
    required this.onNavigateTo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Bienvenido, $username!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.home, size: 50, color: theme.colorScheme.primary),
                    const SizedBox(height: 10),
                    Text(
                      'Esta es la pantalla principal de la aplicación',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Usa el menú lateral o la barra de navegación inferior para explorar las diferentes secciones.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildFeatureCard(context, Icons.pets, 'Pokemons', () => onNavigateTo(1)),
                _buildFeatureCard(context, Icons.person, 'Perfil', () => onNavigateTo(2)),
                _buildFeatureCard(context, Icons.settings, 'Configuración', () => onNavigateTo(3)),
                _buildFeatureCard(context, Icons.notifications, 'Notificaciones', () => onNavigateTo(4)),
                _buildFeatureCard(context, Icons.help, 'Ayuda', () => onNavigateTo(5)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: theme.colorScheme.secondary),
              const SizedBox(height: 10),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _FeaturePage {
  final String title;
  final IconData icon;
  final Widget page;

  _FeaturePage({
    required this.title,
    required this.icon,
    required this.page,
  });
}
