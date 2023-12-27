import 'dart:async';

import 'package:flutter/material.dart';
import 'package:here_hackathon/utils/const.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int displayedText = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    startAnimation();
  }

  void startAnimation() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        logger.d("$displayedText");
        displayedText++;
        displayedText = displayedText % 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text("Let's Order Food"),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              // Search Bar in the Bottom
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Search for ", style: TextStyle(color: Colors.black)),
                          TextAnimatorSequence(
                            tapToProceed: true,
                            loop: true,
                            transitionTime: const Duration(seconds: 1),
                            children: [
                              TextAnimator(
                                "'Pasta'",
                                characterDelay: Duration.zero,
                                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
                                // atRestEffect: WidgetRestingEffects.bounce(),
                                outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              TextAnimator(
                                "'Sandwich'",
                                characterDelay: Duration.zero,
                                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
                                // atRestEffect: WidgetRestingEffects.fidget(),
                                outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              TextAnimator(
                                "'Pizza'",
                                characterDelay: Duration.zero,
                                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
                                // atRestEffect: WidgetRestingEffects.fidget(),
                                outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.mic,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: const Column(),
      ),
    );
  }
}
