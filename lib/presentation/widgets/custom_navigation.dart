
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';


class CustomNavigation {
  // Private constructor to prevent instantiation
  CustomNavigation._();

  /// Push a new route
  static void push(BuildContext context, Widget page, {bool fullscreenDialog = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog
      )
    );
  }

  /// Push a new route with custom page transition
  static void pushWithTransition(
    BuildContext context, 
    Widget page, {
    Offset beginOffset = const Offset(1.0, 0.0),
    Curve curve = Curves.easeInOut,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = beginOffset;
          var end = Offset.zero;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      )
    );
  }

  /// Replace the current route
  static void replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page)
    );
  }


////////////////
  static void pushReplaceWithTransition(
    BuildContext context, 
    Widget page, {
    Offset beginOffset = const Offset(1.0, 0.0),
    Curve curve = Curves.easeInOut,
  }) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = beginOffset;
          var end = Offset.zero;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      )
    );
  }

  /// Pop the current route with an optional result
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  /// Check if can pop
  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}


///////////////////////////////
// // Basic push navigation
// CustomNavigation.push(context, ProfileScreen());

// // Push with custom slide transition
// CustomNavigation.pushWithTransition(
//   context, 
//   ProfileScreen(),
//   beginOffset: Offset(0.0, 1.0), // Slide up
//   curve: Curves.elasticOut
// );

// // Replace current route
// CustomNavigation.replace(context, DashboardScreen());

// // Remove all previous routes and go to a new screen
// CustomNavigation.removeUntil(context, LoginScreen());

// // Remove routes except some
// CustomNavigation.removeUntil(
//   context, 
//   HomeScreen(), 
//   predicate: (route) => route.settings.name == '/home'
// );

// // Pop a route
// CustomNavigation.pop(context);

// // Pop with a result
// CustomNavigation.pop(context, 'Some return value');
// void navigateToMainPage(BuildContext context, int pageIndex) {
//   // Navigate to ScreenMainPage
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (context) => ScreenMainPage()),
//   );

//   // After navigation, update the BLoC to show the desired page
//   BlocProvider.of<BottomNavigationBloc>(context).add(
//     NavigateToPageEvent(pageIndex: pageIndex),
//   );
// }
void navigateToMainPage(BuildContext context, int pageIndex) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Screenmainpage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );

  // Delay updating BLoC to ensure smooth transition
  Future.delayed(const Duration(milliseconds: 100), () {
    // ignore: use_build_context_synchronously
    BlocProvider.of<BottomNavigationBloc>(context).add(
      NavigateToPageEvent(pageIndex: pageIndex),
    );
  });
}
