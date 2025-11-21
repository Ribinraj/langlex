import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';

class BottomNavigationCurvedBar extends StatelessWidget {
  final void Function(int)? onTap;
  const BottomNavigationCurvedBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
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
          onTap: onTap,
        );
      },
    );
  }
}