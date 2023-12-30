import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/models/shop_model.dart';
import '../../logic/stores/order_store.dart';
import '../../utils/const.dart';
import '../../utils/typography.dart';
import 'restraunt_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<String> categories = ["All", "Indian", "Pizza", "Continental", "Chinese", "Cafe"];
  int selected = 0;
  final TextEditingController _searchController = TextEditingController();
  late List<ShopModel> shops;

  @override
  void initState() {
    super.initState();
    shops = context.read<OrderStore>().shops.values.toList();
    logger.d(shops[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DELIVER TO",
                  style: Typo.bodyLarge.copyWith(color: Colors.orange, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "IIT Bombay, Main Gate",
                  style: Typo.bodyMedium,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag_rounded))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Hey Prerak,",
                  style: Typo.bodyLarge,
                ),
                Text(
                  " Good Afternoon",
                  style: Typo.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search dishes, restraunts',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "All Categories",
                  style: Typo.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all >",
                    style: Typo.titleMedium.copyWith(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 45,
              child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selected == index ? Colors.orange : Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: selected == index ? Colors.orange : Colors.white,
                                offset: const Offset(3, 3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            categories[index],
                            style: Typo.bodyLarge.copyWith(color: selected == index ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Open Restraunts",
                  style: Typo.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all >",
                    style: Typo.titleMedium.copyWith(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  return RestrauntWidget(name: shops[index].name, accessories: shops[index].accessories!, imageUrl: shops[index].imageUrl, status: shops[index].status, rating: shops[index].rating);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
