import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/cubits/password_visiblity.dart';
import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';
import 'package:langlex/presentation/screens/signup_page/screen_signup_page.dart';
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

class _ScreenLoginpageState extends State<ScreenLoginpage> {
  final TextEditingController usernameController = TextEditingController();
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
                      height: h(context) * .1,
                    ),
                    Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      height: h(context) * 0.15,
                      width: w(context) * 0.5,
                    ),
                    SizedBox(
                      height: h(context) * .03,
                    ),
                    CustomTextfield(
                      validator: validateUsername,
                      controller: usernameController,
                      labelText: 'Username',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: h(context) * .03,
                    ),
                    BlocBuilder<TogglepasswordCubit, bool>(
                      builder: (context, state) {
                        return CustomTextfield(
                            suffixIcon: togglePassword(),
                            obscureText: state,
                            validator: validatePassword,
                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            labelText: 'Password');
                      },
                    ),
                    SizedBox(
                      height: h(context) * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Text('Forgot Password?',
                                style: TextStyle(
                                    color: Appcolors.ktextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppDimensions.fontSize15(context))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(context) * .03,
                    ),
                    CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              usernameController.text == 'ribin' &&
                              passwordController.text == '1234Ribin') {
                            navigatePush(context,Screenmainpage());
                          } else {
                            customSnackbar(context, 'Fill all fields',
                                Appcolors.kredcolor);
                          }
                        },
                        buttonText: 'Go'),
                    SizedBox(
                      height: h(context) * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont Have Account yet?',
                          style: TextStyle(
                              color: Appcolors.ktextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.fontSize15(context)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSignupPage()));
                          },
                          child: Text(
                            'Signup',
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
