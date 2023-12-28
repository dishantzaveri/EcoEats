// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:here_hackathon/logic/stores/location_store.dart';
import 'package:here_hackathon/logic/stores/order_store.dart';
import 'package:provider/provider.dart';

import '../../logic/stores/auth_store.dart';
import '../../utils/const.dart';
import '../../utils/routes/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<void> initApis() async {
    logger.d("initApis");
    context.read<LocationStore>().initLocation();
    context.read<OrderStore>().init();
    if (!context.read<AuthStore>().isAuthenticated) {
      context.read<AuthStore>().authStateChanges();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    );
    _animationController.forward();
    super.initState();
    handleNavigation();
  }

  void handleNavigation() async {
    await initApis();

    // wait 1 second
    await Future.delayed(const Duration(milliseconds: 2000));

    if (context.read<AuthStore>().isAuthenticated) {
      if (context.mounted) {
        AutoRouter.of(context).replace(const OnboardingRoute());
      }
    } else {
      if (context.mounted) {
        AutoRouter.of(context).replace(const OnboardingRoute());
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/eco_eats_dark.png'),
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
