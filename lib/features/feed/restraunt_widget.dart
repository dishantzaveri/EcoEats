import 'package:flutter/material.dart';
import 'package:here_hackathon/utils/typography.dart';

class RestrauntWidget extends StatelessWidget {
  const RestrauntWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network("https://source.unsplash.com/random/400x200"),
            ),
            Text(
              "Restraunt YAY",
              style: Typo.titleLarge.copyWith(),
            ),
            Text(
              "Burger • Chinese • Cafe • Fast Food",
              style: Typo.titleMedium.copyWith(color: Colors.grey),
            ),
            Row(
              children: [
                Icon(Icons.star_border, ),
                Text(
                  "4.7",
                  style: Typo.bodyMedium,
                ),
                SizedBox(width: 20,),
                Icon(Icons.fire_truck_outlined,),
                Text(
                  "Free",
                  style: Typo.bodyMedium,
                ),
                SizedBox(width: 20,),
                Icon(Icons.timelapse_sharp,),
                Text(
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
