import 'package:flutter/material.dart';


void customSnackbar(context, message,color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      duration: const Duration(milliseconds: 1200),
    ),
  );
}