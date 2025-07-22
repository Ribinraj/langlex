import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/cubits/password_visiblity.dart';
import 'package:langlex/presentation/screens/languagepage/languagepage.dart';

import 'package:langlex/presentation/widgets/custom_elevatedbutton.dart';
import 'package:langlex/presentation/widgets/custom_textfield.dart';
import 'package:langlex/presentation/widgets/custom_validators.dart';

class ScreenSignupPage extends StatefulWidget {
  const ScreenSignupPage({super.key});

  @override
  State<ScreenSignupPage> createState() => _ScreenSignupPageState();
}

class _ScreenSignupPageState extends State<ScreenSignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundimage, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ResponsiveSizedBox.height50,
                    Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      height: ResponsiveUtils.hp(15),
                      width: ResponsiveUtils.wp(30),
                    ),
                    CustomTextfield(
                      validator: validateUsername,
                      controller: usernameController,
                      labelText: 'Username',
                      textInputType: TextInputType.name,
                    ),
                    ResponsiveSizedBox.height5,
                    CustomTextfield(
                        validator: validateMobileNumber,
                        controller: phonenumberController,
                        labelText: 'Mobile number'),
                    ResponsiveSizedBox.height5,
                    CustomTextfield(
                        validator: validateEmail,
                        controller: emailController,
                        labelText: 'Email id'),
                    ResponsiveSizedBox.height5,
                    BlocBuilder<TogglepasswordCubit, bool>(
                      builder: (context, state) {
                        return CustomTextfield(
                            suffixIcon: togglePassword(),
                            validator: validatePassword,
                            obscureText: state,
                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            labelText: 'Password');
                      },
                    ),
                    ResponsiveSizedBox.height5,
                    CustomElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ScreenLanguagePage(selectedLanguages: ,)));
                        },
                        buttonText: 'Sign up'),
                    ResponsiveSizedBox.height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextStyles.medium(
                            text: 'Already you hava an account?',
                            weight: FontWeight.bold),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: TextStyles.body(
                              text: 'Sign in',
                              color: Appcolors.kprimarycolor,
                              weight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
