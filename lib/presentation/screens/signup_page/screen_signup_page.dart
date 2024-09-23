import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/cubits/password_visiblity.dart';
import 'package:langlex/presentation/screens/languagepage/languagepage.dart';

import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';

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
                    SizedBox(
                      height: h(context) * .03,
                    ),
                    Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      height: h(context) * 0.15,
                      width: w(context) * 0.5,
                    ),
                    CustomTextfield(
                      validator: validateUsername,
                      controller: usernameController,
                      labelText: 'Username',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: h(context) * .015,
                    ),
                    CustomTextfield(
                        validator: validateMobileNumber,
                        controller: phonenumberController,
                        labelText: 'Mobile number'),
                    SizedBox(
                      height: h(context) * .015,
                    ),
                    CustomTextfield(
                        validator: validateEmail,
                        controller: emailController,
                        labelText: 'Email id'),
                    SizedBox(
                      height: h(context) * .015,
                    ),
                    BlocBuilder<TogglepasswordCubit,bool>(
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
                    SizedBox(
                      height: h(context) * .015,
                    ),
                    CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenLanguagePage()));
                        },
                        buttonText: 'Sign up'),
                    SizedBox(
                      height: h(context) * .015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already you hava an account?',
                          style: TextStyle(
                              color: Appcolors.ktextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.fontSize15(context)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.fontSize17(context),
                                color: Appcolors.kgreenColor),
                          ),
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
