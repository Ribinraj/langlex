import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langlex/core/colors.dart';

class RegisterLoadingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const RegisterLoadingButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: const Color(0xFF667EEA).withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: SpinKitCircle(
        size: 15,
        color: Appcolors.korangeColor,
      ),
    );
  }
}
