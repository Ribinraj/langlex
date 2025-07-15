import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langlex/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:langlex/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:langlex/presentation/blocs/verify_user_bloc/verify_user_bloc.dart';
import 'package:langlex/presentation/screens/screen_student_registration/screen_registrationpage.dart';
import 'package:langlex/presentation/widgets/custom_loadingbutton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';
import 'package:langlex/presentation/widgets/custom_elevatedbutton.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_snakebar.dart';

class ScreenOtpVerification extends StatefulWidget {
  final String mobileNumber;
  final String customerId;

  const ScreenOtpVerification({
    super.key,
    required this.mobileNumber,
    required this.customerId,
  });

  @override
  State<ScreenOtpVerification> createState() => _ScreenOtpVerificationState();
}

class _ScreenOtpVerificationState extends State<ScreenOtpVerification>
    with SingleTickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  // ignore: unused_field
  bool _isButtonEnabled = false;
  int _resendTimer = 30;
  Timer? _timer;
  String _currentOtp = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _startResendTimer();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _animationController.dispose();

    try {
      _otpController.dispose();
    } catch (e) {
      // Controller already disposed, ignore
    }

    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetResendTimer() {
    if (!mounted) return;
    setState(() {
      _resendTimer = 30;
    });
    _startResendTimer();
  }

  void _resendOtp() {
    if (!mounted) return;

    // Clear OTP field safely
    // ignore: invalid_use_of_protected_member
    if (_otpController.hasListeners) {
      _otpController.clear();
    }

    setState(() {
      _currentOtp = '';
      _isButtonEnabled = false;
    });

    // Reset and restart the timer
    _resetResendTimer();
    context
        .read<ResendOtpBloc>()
        .add(ResendOtpButtonClickEvent(mobileNumber: widget.mobileNumber));
    // // Show success message
    // customSnackbar(
    //   context,
    //   'OTP sent successfully',
    //   Appcolors.kgreenlightColor,
    // );
  }

  void _verifyOtp() {
    if (_currentOtp.length == 6) {
      // Simulate OTP verification
      customSnackbar(
        context,
        'OTP verified successfully',
        Appcolors.kgreenlightColor,
      );

      // Navigate to main page after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        CustomNavigation.replace(context, Screenmainpage());
      });
    } else {
      customSnackbar(
        context,
        'Please enter valid OTP',
        Appcolors.kredcolor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              backgroundimage,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(.18),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Content
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                ResponsiveSizedBox.height10,

                // Back Button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Logo
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        logo,
                        fit: BoxFit.contain,
                        height: ResponsiveUtils.hp(10),
                        width: ResponsiveUtils.wp(20),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(4)),

                // OTP Verification Form
                SlideTransition(
                  position: _slideAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 21, 132, 78)
                              .withOpacity(0.3), // Very light overlay
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            // Title and Description
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Column(
                                children: [
                                  Text(
                                    'Verification Code',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ResponsiveSizedBox.height10,
                                  Text(
                                    'We have sent a verification code to\n${widget.mobileNumber}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            ResponsiveSizedBox.height10,

                            // OTP Input Field
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  controller: _otpController,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    inactiveBorderWidth: 1,
                                    activeBorderWidth: 2,
                                    selectedBorderWidth: 2,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(12),
                                    fieldHeight: 50,
                                    fieldWidth: 45,
                                    activeFillColor:
                                        Colors.white.withOpacity(0.1),
                                    inactiveFillColor: const Color.fromARGB(
                                        255, 228, 217, 217),
                                    selectedFillColor:
                                        Colors.white.withOpacity(0.15),
                                    activeColor: Appcolors.kpurplecolor,
                                    inactiveColor: Appcolors.kprimarycolor,
                                    selectedColor: Colors.white,
                                  ),
                                  cursorColor: Colors.white,
                                  cursorWidth: 2,
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onCompleted: (value) {
                                    if (!mounted) return;
                                    setState(() {
                                      _isButtonEnabled = true;
                                      _currentOtp = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    if (!mounted) return;
                                    setState(() {
                                      _currentOtp = value;
                                      _isButtonEnabled = value.length == 6;
                                    });
                                  },
                                ),
                              ),
                            ),

                            ResponsiveSizedBox.height10,

                            // Verify Button
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child:
                                  BlocConsumer<VerifyUserBloc, VerifyUserState>(
                                listener: (context, state) {
                                  if (state is VerifyUserSuccessState) {
                                    log('success');
                                    CustomNavigation.pushReplaceWithTransition(
                                        context, ScreenStudentRegistration());
                                  } else if (state is VerifyUserErrorState) {
                                    customSnackbar(
                                      context,
                                      state.message,
                                      Appcolors.kredcolor,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is VerifyUserLoadingState) {
                                    return const CustomLoadingElevatedButton(
                                        loading: SpinKitCircle(
                                          size: 15,
                                          color: Appcolors.korangeColor,
                                        ),
                                        color: Appcolors.kwhiteColor);
                                  }
                                  return CustomElevatedButton(
                                    onPressed: _isButtonEnabled
                                        ? () {
                                            if (_currentOtp.length == 6) {
                                              context
                                                  .read<VerifyUserBloc>()
                                                  .add(VerifyExistingUserEvent(
                                                      userId: widget.customerId,
                                                      otp: _currentOtp));
                                            } else {
                                              customSnackbar(
                                                  context,
                                                  'Please Enter Valid OTP',
                                                  Appcolors.kredcolor);
                                            }
                                          }
                                        : null,
                                    buttonText: 'Verify OTP',
                                  );
                                },
                              ),
                            ),

                            ResponsiveSizedBox.height10,

                            // Resend OTP Section
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Didn't receive OTP? ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  BlocConsumer<ResendOtpBloc, ResendOtpState>(
                                    listener: (context, state) {
                                          if (state is ResendOtpSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("OTP sent successfully")),
                            );
                          } else if (state is ResendOtpErrorState) {
                                                       ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                                    },
                                    builder: (context, state) {
                                      return TextButton(
                                        onPressed: _resendTimer == 0
                                            ? _resendOtp
                                            : null,
                                        child: Text(
                                          _resendTimer > 0
                                              ? '$_resendTimer seconds'
                                              : 'Resend',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: _resendTimer > 0
                                                ? Colors.white.withOpacity(0.5)
                                                : Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
