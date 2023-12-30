import 'package:flutter/material.dart';

import '../../utils/typography.dart';

class RestrauntWidget extends StatelessWidget {
  const RestrauntWidget(
      {super.key,
      required this.name,
      required this.accessories,
      required this.imageUrl,
      required this.status,
      required this.rating});

  final String name;
  final String imageUrl;
  final String rating;
  final String status;
  final List<String> accessories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(imageUrl),
            //"https://source.unsplash.com/random/400x200?sig=${Random().nextInt(100)}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Typo.titleLarge.copyWith(),
              ),
              Text(
                status,
                style: Typo.titleMedium.copyWith(color: Colors.green),
              ),
            ],
          ),
          Text(
            accessories.join(" • "),
            style: Typo.titleMedium.copyWith(color: Colors.grey),
          ),
          Row(
            children: [
              const Icon(
                Icons.star_border,
              ),
              Text(
                rating,
                style: Typo.bodyMedium,
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.fire_truck_outlined,
              ),
              const Text(
                "Free",
                style: Typo.bodyMedium,
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.timelapse_sharp,
              ),
              const Text(
                "20 mins",
                style: Typo.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
