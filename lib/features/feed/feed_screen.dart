import 'package:flutter/material.dart';
import 'package:here_hackathon/features/feed/restraunt_widget.dart';
import 'package:here_hackathon/logic/stores/order_store.dart';
import 'package:here_hackathon/utils/const.dart';
import 'package:here_hackathon/utils/typography.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<String> categories = [
    "All",
    "Indian",
    "Pizza",
    "Continental",
    "Chinese",
    "Cafe"
  ];
  int selected = 0;
  TextEditingController _searchController = TextEditingController();
  var shops;

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
                  style: Typo.bodyLarge.copyWith(
                      color: Colors.orange, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "IIT Bombay, Main Gate",
                  style: Typo.bodyMedium,
                )
              ],
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.shopping_bag_rounded))
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
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
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
                Text(
                  "All Categories",
                  style: Typo.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all >",
                    style: Typo.titleMedium.copyWith(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black),
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
                            color: selected == index
                                ? Colors.orange
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: selected == index
                                    ? Colors.orange
                                    : Colors.white,
                                offset: Offset(3, 3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            categories[index],
                            style: Typo.bodyLarge.copyWith(
                                color: selected == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Open Restraunts",
                  style: Typo.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all >",
                    style: Typo.titleMedium.copyWith(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  return RestrauntWidget(
                      name: shops[index].name,
                      accessories: shops[index].accessories,
                      imageUrl: shops[index].imageUrl,
                      status: shops[index].status,
                      rating: shops[index].rating);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
