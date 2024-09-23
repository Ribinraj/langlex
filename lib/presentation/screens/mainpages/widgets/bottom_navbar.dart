// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:langlex/core/colors.dart';

// ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

// class BottomNavigationWidget extends StatelessWidget {
//   const BottomNavigationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: indexChangeNotifier,
//         builder: (context, int newIndex, _) {
//           return Container(
//             decoration: const BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                   color: Appcolors.kblackColor, // Color of the line
//                   width: 1.0, // Thickness of the line
//                 ),
//               ),
//             ),
//             child: BottomNavigationBar(
//                 currentIndex: newIndex,
//                 onTap: (index) {
//                   indexChangeNotifier.value = index;
//                 },
//                 type: BottomNavigationBarType.fixed,
//                 backgroundColor: Appcolors.kwhiteColor,
//                 selectedItemColor: Appcolors.kblackColor,
//                 unselectedItemColor: Colors.grey,
//                 selectedIconTheme:
//                     const IconThemeData(color: Appcolors.kblackColor),
//                 unselectedIconTheme: const IconThemeData(color: Colors.grey),
//                 items: const [
//                   BottomNavigationBarItem(
//                       icon: Icon(
//                         CupertinoIcons.home,
//                       ),
//                       label: 'Home'),
//                   BottomNavigationBarItem(
//                       icon: Icon(
//                         CupertinoIcons.search,
//                       ),
//                       label: 'Search'),
//                   BottomNavigationBarItem(
//                       icon: Icon(
//                         Icons.person,
//                       ),
//                       label: 'Profile'),
//                 ]),
//           );
//         });
//   }
// }
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/presentation/screens/homepage/homepage.dart';
import 'package:langlex/presentation/screens/profilepage/profilepage_screen.dart';
import 'package:langlex/presentation/screens/searchpage/searchpage_sreen.dart';

final ValueNotifier<int> currentPage = ValueNotifier(0);

class Screenmainpage extends StatefulWidget {
  const Screenmainpage({super.key});

  @override
  State<Screenmainpage> createState() => _SCreenmainpageState();
}

class _SCreenmainpageState extends State<Screenmainpage> {
  final List<Widget> pages = [
    ScreenHomePage(),
    ScreenSearchPage(),
    const ScreenProfilePage(),
    //const ScreenUserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => IndexedStack(
          index: value,
          children: pages,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Appcolors.kgreenlightColor,
        buttonBackgroundColor: Appcolors.kgreenColor,
        color: Appcolors.kgreenColor,
        height: 55,
        index: currentPage.value,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Appcolors.kwhiteColor,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Appcolors.kwhiteColor,
          ),
          // Icon(
          //   Icons.add,
          //   size: 30,
          //   color: Appcolors.kwhiteColor,
          // ),
          Icon(
            Icons.person,
            size: 30,
            color: Appcolors.kwhiteColor,
          )
        ],
        onTap: (index) {
          currentPage.value = index;
        },
      ),
    );
  }
}
