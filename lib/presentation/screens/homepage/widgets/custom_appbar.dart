import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

import 'package:langlex/presentation/cubits/language_change.dart';

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
  List localCodes = ["en", "hi", "ka"];
  int currentIndex = 0;

  // List of items in the dropdown
  final languages = {'English': 'en', 'हिन्दी': 'hi', 'ಕನ್ನಡ': 'ka'};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        dropdownColor: Appcolors.kbackgroundcolor,
        // hint: const Text(
        //   'English',
        //   style: TextStyle(color: Appcolors.kgreenColor, fontSize: 17),
        // ),
        value: context.read<LanguageCubit>().state,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Appcolors.kgreenColor,
        ),
        iconSize: 28,
        elevation: 14,
        style: TextStyle(
            color: Appcolors.kgreenColor,
            fontSize: AppDimensions.fontSize15(context)),
        underline: Container(
          height: 2,
          color: Appcolors.kbackgroundcolor,
        ),
        onChanged: (String? newValue) {
          if (newValue != null) {
            context.read<LanguageCubit>().changeLanguage(newValue);
            Locales.change(context, newValue);
            
          }
        },
        items: languages.entries.map((entry) {
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

// class CustomDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Drawer Header',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Home screen if needed
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Settings screen if needed
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
