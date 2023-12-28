import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:here_hackathon/logic/stores/location_store.dart';
import 'package:here_hackathon/logic/stores/order_store.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../logic/stores/auth_store.dart';
import '../../utils/const.dart';
import '../../utils/routes/app_router.gr.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

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

    if (context.read<AuthStore>().isAuthenticated) {
      if (context.mounted) {
        AutoRouter.of(context).replace(const MainScaffoldRoute());
      }
    } else {
      if (context.mounted) {
        AutoRouter.of(context).replace(LoginRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/onboarding1.png',
                      height: 350,
                      width: 350,
                    ),
                    Text(
                      "Dating made easy",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Filtered people based on your interests",
                        style: GoogleFonts.lato()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/network.png',
                      height: 350,
                      width: 350,
                    ),
                    Text(
                      "Dating made quick",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "You have 24 hours to chat, its a blind date after all!",
                        style: GoogleFonts.lato()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/hero.png',
                      height: 350,
                      width: 350,
                    ),
                    Text(
                      "Dating made safe",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Leave your worries aside and find love <3",
                        style: GoogleFonts.lato()),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            // alignment: Alignment.center,
            bottom: 60,
            left: MediaQuery.of(context).size.width * 0.5 - 32,
            child: Column(
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
                Spacer(
                  flex: 1,
                ),
                AnimatedSmoothIndicator(
                  activeIndex: currentPage.round(),
                  count: 3,
                  effect: WormEffect(
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.indigo),
                ),
                Spacer(
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
                    child: currentPage != 2
                        ? const Text('    Next',
                            style: TextStyle(color: Colors.black))
                        : Image.asset("assets/images/location.png",
                            height: MediaQuery.of(context).size.width * 0.06)),
                //SizedBox(height: 24)
              ],
            ),
          ),
        ],
      ),
    );
  }
}