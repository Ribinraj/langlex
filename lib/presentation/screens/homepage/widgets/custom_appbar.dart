import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

import 'package:langlex/presentation/cubits/language_change.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class AppbarSection extends StatelessWidget {
//   final VoidCallback onDrawerButtonPressed; // Callback to open the drawer

//   AppbarSection({
//     Key? key,
//     required this.onDrawerButtonPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Appcolors.korangeColor,
//       title: const Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomRoundImage(
//               circleContainerSize: 44,
//               imageUrl:
//                   'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png'),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.menu), // Drawer icon
//           onPressed: onDrawerButtonPressed,
//         ),
//         DropdownExample(),
//       ],
//       floating: true,
//       toolbarHeight: 60,
//     );
//   }
// }

/////////////////////////
class DropdownExample extends StatefulWidget {
  const DropdownExample({super.key});

  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  // Initial selected value
  String? selectedValue;
  // List localCodes = ["en", "hi", "ka"];
  List<String> localCodes = [];
  Map<String, String> languagesdropdown = {};
  int currentIndex = 0;
//
  final List<Map<String, String>> languages = [
    {'English': 'en'},
    {'हिन्दी': 'hi'},
    {'ಕನ್ನಡ': 'ka'},
    {'தமிழ்': 'ta'},
    {'मराठी': 'mr'}
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStoredlanguages();
  }

  // List of items in the dropdown
  // final languagesdropdown = {'English': 'en', 'हिन्दी': 'hi', 'ಕನ್ನಡ': 'ka'};
  Future<void> loadStoredlanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedLanguages = prefs.getStringList('SELECTEDLANGUAGES');
    setState(() {
      if (storedLanguages != null && storedLanguages.isNotEmpty) {
        localCodes = storedLanguages;
      } else {
        localCodes = ["en", "hi", "ka"];
      }
      log(localCodes.toString());
      languagesdropdown.clear();
      for (var code in localCodes) {
        for (var language in languages) {
          if (language.values.first == code) {
            languagesdropdown[language.keys.first] = language.values.first;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        dropdownColor: Appcolors.kgreenlightColor,
        // hint: const Text(
        //   'English',
        //   style: TextStyle(color: Appcolors.kgreenColor, fontSize: 17),
        // ),
        value: context.read<LanguageCubit>().state,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Appcolors.kwhiteColor,
        ),
        iconSize: 28,
        elevation: 14,
        style: TextStyle(
          color: Appcolors.kwhiteColor,
          fontSize: ResponsiveUtils.hp(2),
        ),
        underline: SizedBox.shrink(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            context.read<LanguageCubit>().changeLanguage(newValue);
            Locales.change(context, newValue);
          }
        },
        items: languagesdropdown.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.value,
            child: Text(entry.key),
          );
        }).toList(),
      ),
    );
  }
}

///

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Appcolors.kprimarycolor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Appcolors.kwhiteColor,
                ),
                width: ResponsiveUtils.hp(12.5),
                height: ResponsiveUtils.wp(25),
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                ),
              ),
              ResponsiveSizedBox.height10,
              TextStyles.body(
                  text: 'Hii Ribin',
                  weight: FontWeight.bold,
                  color: Appcolors.kwhiteColor),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.people_outlined),
          title: TextStyles.body(
              text: 'About Us',
              weight: FontWeight.bold,
              color: Appcolors.kblackColor),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.add_ic_call_outlined),
          title: TextStyles.body(
              text: 'Contact Us',
              weight: FontWeight.bold,
              color: Appcolors.kblackColor),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
          title: TextStyles.body(
              text: 'Privacy Policy',
              weight: FontWeight.bold,
              color: Appcolors.kblackColor),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
          title: TextStyles.body(
              text: 'Terms & Condition',
              weight: FontWeight.bold,
              color: Appcolors.kblackColor),
          onTap: () {},
        ),
        const Divider(),
        Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: TextStyles.body(
                  text: 'Logout',
                  weight: FontWeight.bold,
                  color: Appcolors.kblackColor),
              onTap: () async {},
            ),
            ResponsiveSizedBox.height10,
          ],
        ),
      ],
    ));
  }
}
