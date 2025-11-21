// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:langlex/core/colors.dart';
// import 'package:langlex/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';

// import 'package:langlex/presentation/screens/homepage/homepage.dart';
// import 'package:langlex/presentation/screens/profilepage/profilepage_screen.dart';
// import 'package:langlex/presentation/screens/screen_connectivitypage/screen_connectivitypage.dart';
// import 'package:langlex/presentation/screens/searchpage/searchpage_sreen.dart';


// class Screenmainpage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final List<Widget> pages = [
//     ScreenHomePage(),
//     const ScreenSearchPage(),
//     const ScreenProfilePage(),
//   ];

//   Screenmainpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//         builder: (context, state) {
//           return ConnectivityAwareWidget(
//             child: PageView(
//               controller: _pageController,
//               physics: const NeverScrollableScrollPhysics(),
//               children: pages,
//               onPageChanged: (index) {
//                 context
//                     .read<BottomNavigationBloc>()
//                     .add(NavigateToPageEvent(pageIndex: index));
//               },
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar:
//           BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//         builder: (context, state) {
//           return CurvedNavigationBar(
//             backgroundColor: Appcolors.kgreenlightColor,
//             buttonBackgroundColor: Appcolors.kprimarycolor,
//             color: Appcolors.kprimarycolor,
//             height: 55,
//             index: state.currentPageIndex,
//             items: const <Widget>[
//               Icon(
//                 Icons.home,
//                 size: 30,
//                 color: Appcolors.kwhiteColor,
//               ),
//               Icon(
//                 Icons.search,
//                 size: 30,
//                 color: Appcolors.kwhiteColor,
//               ),
//               Icon(
//                 Icons.person,
//                 size: 30,
//                 color: Appcolors.kwhiteColor,
//               ),
//             ],
//             onTap: (index) {
//               context
//                   .read<BottomNavigationBloc>()
//                   .add(NavigateToPageEvent(pageIndex: index));
//               _pageController.jumpToPage(index);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';

import 'package:langlex/presentation/screens/homepage/homepage.dart';

import 'package:langlex/presentation/screens/searchpage/searchpage_sreen.dart';
import 'package:langlex/presentation/screens/profilepage/profilepage_screen.dart';
import 'package:langlex/presentation/screens/screen_connectivitypage/screen_connectivitypage.dart';


import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:langlex/core/colors.dart';


class Screenmainpage extends StatefulWidget {
  const Screenmainpage({super.key});

  @override
  State<Screenmainpage> createState() => _ScreenmainpageState();
}

class _ScreenmainpageState extends State<Screenmainpage> {
  late final PageController _pageController;

  final List<Widget> pages = const [
    ScreenHomePage(),
    ScreenSearchPage(),
    ScreenProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // 🔹 Read current index from BLoC when we create this screen
    final initialIndex =
        context.read<BottomNavigationBloc>().state.currentPageIndex;
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityAwareWidget(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            backgroundColor: Appcolors.kgreenlightColor,
            buttonBackgroundColor: Appcolors.kprimarycolor,
            color: Appcolors.kprimarycolor,
            height: 55,
            index: state.currentPageIndex,
            items: const [
              Icon(Icons.home, size: 30, color: Appcolors.kwhiteColor),
              Icon(Icons.search, size: 30, color: Appcolors.kwhiteColor),
              Icon(Icons.person, size: 30, color: Appcolors.kwhiteColor),
            ],
            onTap: (index) {
              // 🔹 Update page + bloc together
              _pageController.jumpToPage(index);
              context
                  .read<BottomNavigationBloc>()
                  .add(NavigateToPageEvent(pageIndex: index));
            },
          );
        },
      ),
    );
  }
}
