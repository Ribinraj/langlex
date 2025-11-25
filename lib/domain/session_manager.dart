import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SessionManager {
  static bool _isDialogShowing = false;

  static Future<void> handleExpiredToken(BuildContext? context) async {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    log('Token expired - clearing session');
    
    // Clear stored token
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('USER_TOKEN');
      log('Token cleared from SharedPreferences');
    } catch (e) {
      log('Error clearing token: $e');
    }

    final navContext = context ?? NavigationService().context;
    
    if (navContext != null && navContext.mounted) {
      await showDialog(
        context: navContext,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return WillPopScope(
            onWillPop: () async => false, // Prevent back button
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange[700],
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Session Expired',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              content: const Text(
                'Your session has expired. Please login again to continue using the app.',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _isDialogShowing = false;
                      
                Navigator.of(navContext).pushAndRemoveUntil(
  MaterialPageRoute(builder: (_) => ScreenLoginpage()),
  (route) => false,
);

                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login Again',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
