import 'package:flutter/material.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';

import 'package:langlex/presentation/widgets/custom_elevatedbutton.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_snakebar.dart';
import 'package:langlex/presentation/widgets/custom_textfield.dart';
import 'package:langlex/presentation/widgets/custom_validators.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  State<ScreenLoginpage> createState() => _ScreenLoginpageState();
}

class _ScreenLoginpageState extends State<ScreenLoginpage>
    with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
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
    _animationController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundimage,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(.2),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Content
          SafeArea(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  SizedBox(height: ResponsiveUtils.hp(5)),

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
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(30),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(5)),

                  // Login Form
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Welcome Text
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              children: [
                                Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    fontSize: 28,
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
                                const SizedBox(height: 8),
                                Text(
                                  'Enter your mobile number to continue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          ResponsiveSizedBox.height10,

                          // Mobile Number Field
                          CustomTextfield(
                            validator: validateUsername,
                            controller: usernameController,
                            labelText: 'Enter Mobile Number',
                            textInputType: TextInputType.phone,
                          ),

                          ResponsiveSizedBox.height10,

                          // Sign In Button
                          CustomElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  usernameController.text == 'ribin') {
                                CustomNavigation.replace(
                                    context, Screenmainpage());
                              } else {
                                customSnackbar(
                                  context,
                                  'Please enter a valid mobile number',
                                  Appcolors.kredcolor,
                                );
                              }
                            },
                            buttonText: 'Sign In',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
////////////////////////////
              // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     TextStyles.medium(
                    //         text: 'Dont Have Account yet?',
                    //         weight: FontWeight.bold,
                    //         color: Appcolors.ktextColor),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const ScreenSignupPage()));
                    //       },
                    //       child: TextStyles.body(
                    //           text: 'Signup',
                    //           weight: FontWeight.bold,
                    //           color: Appcolors.kprimarycolor),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     )
                    //   ],
                    // )
                    ////////////////////////
                                   // BlocBuilder<TogglepasswordCubit, bool>(
                    //   builder: (context, state) {
                    //     return CustomTextfield(
                    //         suffixIcon: togglePassword(),
                    //         obscureText: state,
                    //         validator: validatePassword,
                    //         controller: passwordController,
                    //         textInputType: TextInputType.visiblePassword,
                    //         labelText: 'Password');
                    //   },
                    // ),
                    // ResponsiveSizedBox.height10,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(right: 10),
                    //       child: InkWell(
                    //         onTap: () {},
                    //         child: TextStyles.body(
                    //             text: 'Forgot Password?',
                    //             color: Appcolors.korangeColor,
                    //             weight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ],
                    // ),