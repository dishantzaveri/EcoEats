import 'package:flutter/material.dart';

import '../../utils/palette.dart';
import 'constants/colors.dart';
import 'constants/textstyles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Palette.pureBlack,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Shreyas',
                    style: TextStyles.pageHeading,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('abc@gmail.com'),
                      Row(
                        children: <Widget>[
                          Text(
                            'View dineline',
                            style: TextStyle(
                              color: AppColors.highlighterPink,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: AppColors.highlighterPink,
                          )
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage('https://avatars1.githubusercontent.com/u/60895972?s=460&v=4'),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.bookmark),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Bookmarks')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.notifications),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Notifications')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.settings),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Settings')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.payment),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Payments')
                      ],
                    ),
                  ],
                ),
                Divider(),
                ListTile(
                  title: Text('Zomato Gold'),
                  trailing: Icon(Icons.arrow_right),
                ),
                Divider(),
                Text(
                  'Food Orders',
                  style: TextStyles.actionTitleWhite,
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_bag,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Your Orders',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  leading: Icon(
                    Icons.linked_camera,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Favorite Orders',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_a_photo,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Address Book',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  leading: Icon(
                    Icons.message,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Online Ordering Help',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(),
                Text(
                  'food@word',
                  style: TextStyles.actionTitleWhite,
                ),
                ListTile(
                  leading: Icon(
                    Icons.fork_right,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Enable',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(),
                Text(
                  'Table Bookings',
                  style: TextStyles.actionTitleWhite,
                ),
                ListTile(
                  leading: Icon(
                    Icons.book_online,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Your Bookings',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  leading: Icon(
                    Icons.bookmark_border,
                    color: AppColors.whiteColor,
                  ),
                  title: Text(
                    'Table Reservation Help',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'About',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Send Feedback',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  title: Text(
                    'Report a Safety Emergency',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  title: Text(
                    'Rate us on the Play Store',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  title: Text(
                    'Log Out',
                    // style: TextStyles.highlighterTwo,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
