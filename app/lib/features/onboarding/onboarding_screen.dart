import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../logic/stores/auth_store.dart';
import '../../logic/stores/location_store.dart';
import '../../logic/stores/order_store.dart';
import '../../utils/const.dart';
import '../../utils/routes/app_router.gr.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  Future<void> initApis() async {
    logger.d("initApis");
    context.read<LocationStore>().initLocation();
    context.read<OrderStore>().init();
    if (!context.read<AuthStore>().isAuthenticated) {
      context.read<AuthStore>().authStateChanges();
    }
  }

  void handleNavigation() async {
    await initApis();

    // wait 1 second
    await Future.delayed(const Duration(milliseconds: 2000));

    if (context.mounted) {
      if (context.read<AuthStore>().isAuthenticated) {
        AutoRouter.of(context).replace(const MainScaffoldRoute());
      } else {
        AutoRouter.of(context).replace(LoginRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/location.png',
                    height: 350,
                    width: 350,
                  ),
                  Text(
                    "Delivery made easy",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("", style: GoogleFonts.lato()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/network.png',
                    height: 350,
                    width: 350,
                  ),
                  Text(
                    "Delivery made quick",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Sustainable and Eco-friendly delivery at your doorstep", style: GoogleFonts.lato()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/hero.png',
                    height: 350,
                    width: 350,
                  ),
                  Text(
                    "Delivery is your hero",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Reduce your carbon footprint", style: GoogleFonts.lato()),
                ],
              ),
            ],
          ),
          Positioned(
            // alignment: Alignment.center,
            bottom: 60,
            left: MediaQuery.of(context).size.width * 0.5 - 32,
            child: const Column(
              children: [
                SizedBox(height: 24),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(
                  flex: 1,
                ),
                AnimatedSmoothIndicator(
                  activeIndex: currentPage.round(),
                  count: 3,
                  effect: const WormEffect(dotWidth: 10.0, dotHeight: 10.0, dotColor: Colors.grey, activeDotColor: Colors.indigo),
                ),
                const Spacer(
                  flex: 5,
                ),
                MaterialButton(
                    height: MediaQuery.of(context).size.width * 0.13,
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {
                        currentPage != 2
                            ? _pageController.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              )
                            : handleNavigation();
                      });
                    },
                    child:
                        currentPage != 3 ? const Text('    Next', style: TextStyle(color: Colors.white)) : Image.asset("assets/images/location.png", height: MediaQuery.of(context).size.width * 0.06)),
                //SizedBox(height: 24)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
