import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';


class LogoutConfirmationDialog extends StatelessWidget {
  final Function onLogout;

  const LogoutConfirmationDialog({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 4,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: Appcolors.kprimarycolor,
                size: 40,
              ),
              const SizedBox(height: 20),
              TextStyles.subheadline(
                text: 'Logout',
                weight: FontWeight.bold,
                color: Appcolors.kprimarycolor,
              ),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Appcolors.kgreenlightColor,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  // Yes Button
                  ElevatedButton(
                    onPressed: () => onLogout(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.kredcolor,
                      foregroundColor: Appcolors.kwhiteColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(5),
                        vertical: ResponsiveUtils.hp(1.2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
