import 'package:flutter/material.dart';
import '../auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary, // ✅ usa color del tema
      extendBodyBehindAppBar: true,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/icons/logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Mi App Flutter',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary, // ✅ contraste automático
                ),
              ),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                color: theme.colorScheme.onPrimary, // ✅ usa color del tema
              ),
            ],
          ),
        ),
      ),
    );
  }
}
