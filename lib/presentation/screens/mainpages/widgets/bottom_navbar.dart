
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/presentation/screens/homepage/homepage.dart';
// import 'package:langlex/presentation/screens/profilepage/profilepage_screen.dart';
// import 'package:langlex/presentation/screens/searchpage/searchpage_sreen.dart';

// final ValueNotifier<int> currentPage = ValueNotifier(0);

// class Screenmainpage extends StatefulWidget {
//   const Screenmainpage({super.key});

//   @override
//   State<Screenmainpage> createState() => _SCreenmainpageState();
// }

// class _SCreenmainpageState extends State<Screenmainpage> {
//   final List<Widget> pages = [
//     ScreenHomePage(),
//     ScreenSearchPage(),
//     const ScreenProfilePage(),
//     //const ScreenUserProfile(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder<int>(
//         valueListenable: currentPage,
//         builder: (context, value, child) => IndexedStack(
//           index: value,
//           children: pages,
//         ),
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Appcolors.kgreenlightColor,
//         buttonBackgroundColor: Appcolors.kgreenColor,
//         color: Appcolors.kgreenColor,
//         height: 55,
//         index: currentPage.value,
//         items: const <Widget>[
//           Icon(
//             Icons.home,
//             size: 30,
//             color: Appcolors.kwhiteColor,
//           ),
//           Icon(
//             Icons.search,
//             size: 30,
//             color: Appcolors.kwhiteColor,
//           ),
//           // Icon(
//           //   Icons.add,
//           //   size: 30,
//           //   color: Appcolors.kwhiteColor,
//           // ),
//           Icon(
//             Icons.person,
//             size: 30,
//             color: Appcolors.kwhiteColor,
//           )
//         ],
//         onTap: (index) {
//           currentPage.value = index;
//         },
//       ),
//     );
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
  State<Screenmainpage> createState() => _ScreenmainpageState();
}

class _ScreenmainpageState extends State<Screenmainpage> {
  final PageController _pageController = PageController();

  final List<Widget> pages = [
    ScreenHomePage(),
    ScreenSearchPage(),
    const ScreenProfilePage(),
    // const ScreenUserProfile(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage.addListener(() {
      _pageController.jumpToPage(currentPage.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevents swiping
        children: pages,
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
          Icon(
            Icons.person,
            size: 30,
            color: Appcolors.kwhiteColor,
          ),
        ],
        onTap: (index) {
          currentPage.value = index; // Update the current page index
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }
}
