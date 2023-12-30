import 'dart:math';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final CarouselController _controller = CarouselController();
  int pageIndex = 0;

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
                            // tapToProceed: true,
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
        body: Column(
          children: [
            const SizedBox(height: 20),
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.network("https://source.unsplash.com/random/400x200?sig=${Random().nextInt(100)}"),
                    );
                  },
                );
              }).toList(),
            ),
            CarouselIndicator(
              count: 5,
              index: pageIndex,
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    const SizedBox(width: 20, height: 60),
                    const SizedBox(width: 20, height: 60),
                    for (int index = 0; index < 7; index++) ...[
                      Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: 20,
                                width: 40,
                                child: Image.asset(
                                  "assets/foods/${index + 1}.png",
                                  fit: BoxFit.fitWidth,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
