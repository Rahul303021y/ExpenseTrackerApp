import 'package:expensetrackerapp/core/localization/locale_keys.dart';
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/features/login/login_bloc/login_bloc.dart';
import 'package:expensetrackerapp/features/login/login_data/login_repo.dart';
import 'package:expensetrackerapp/features/login/login_presentation/login_page.dart';
import 'package:expensetrackerapp/shared/common_ui/app_button.dart';
import 'package:expensetrackerapp/shared/utils/clippers.dart';
import 'package:expensetrackerapp/shared/utils/diagonal_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../login_data/login_api_provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.6,
      end: 1.25,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: DiagonalClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6F6),
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(size.width, double.infinity),
                  painter: DiagonalBorderPainter(offset: 80),
                ),
                Container(
                  width: size.width * 1.5,
                  height: size.width * 1.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.85),
                      width: 4,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.82,
                  height: size.width * 0.82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.85),
                      width: 4,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.62,
                  height: size.width * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.85),
                      width: 4,
                    ),
                  ),
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.asset(
                          'asset/lotties/ExpenseTracker_Splash_Screen.json',
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: 80,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(LocaleKeys.appName.tr(context),
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 10,
                                color: Color(0xFF174944),
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                  Shadow(
                                    color: Colors.tealAccent.withOpacity(0.15),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 40,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.quote.tr(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF174944),
                          height: 1.3,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 36),
                      AppButton(
                          text: LocaleKeys.getStarted.tr(context),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => LoginBloc(
                                    LoginRepo(
                                      LoginApiProvider(),
                                      SecureStorageService()
                                    ),
                                  ),
                                  child: LoginPage(),
                                ),
                              ),
                            );
                          },
                          height: 55,
                          backgroundColor: const Color(0xFF174944),
                          textColor: Colors.white),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
