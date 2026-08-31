import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/core/theme/theme.dart';
import 'package:expensetrackerapp/features/home_screen/common/main_screen.dart';
import 'package:expensetrackerapp/features/login/login_data/login_api_provider.dart';
import 'package:expensetrackerapp/features/login/login_presentation/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';

import '../../../core/network/dio_client.dart';
import '../../home_screen/home_screen_bloc/home_screen_bloc.dart';
import '../../home_screen/home_screen_bloc/home_screen_event.dart';
import '../../home_screen/home_screen_data/home_screen_api_provider.dart';
import '../../home_screen/home_screen_data/home_screen_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final repository = HomeScreenRepo(
      HomeScreenApiProvider(DioClient(SecureStorageService()).dio));

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => HomeBloc(
            repository: repository,
          )..add(HomeStarted()),
          child: const MainScreen(),
        ),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const StartScreen()),
    );
  }

  Future<void> _navigate() async {
    final storage = SecureStorageService();

    final accessToken = await storage.getAccessToken();

    if (!mounted) return;

    // 1. No token → login
    if (accessToken == null || accessToken.isEmpty) {
      _goToLogin();
      return;
    }

    // 2. Token still valid → home
    if (!JwtDecoder.isExpired(accessToken)) {
      _goToHome();
      return;
    }

    // 3. Token expired → try refresh
    final refreshToken = await storage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await storage.clear();
      _goToLogin();
      return;
    }

    try {
      final api = LoginApiProvider();

      final result = await api.refreshToken(
        refreshToken: refreshToken,
        deviceId: "Demo",
      );

      // save new tokens
      await storage.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
        accessTokenExpiry: result.accessTokenExpiry,
      );
      if (!mounted) return;
      _goToHome();
    } catch (e) {
      await storage.clear();
      _goToLogin();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(
      begin: 3.0,
      end: 1.6,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 1600), () {
      _navigate();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealBackground,
      body: Column(
        children: [
          Expanded(
            flex: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.tealBackground,
                ),
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: Lottie.asset(
                      'asset/lotties/ExpenseTracker_Splash_Screen.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 40,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
