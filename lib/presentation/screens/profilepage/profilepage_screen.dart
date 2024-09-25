import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';
import 'package:langlex/presentation/screens/loginpage/loginpage.dart';
import 'package:langlex/presentation/screens/profilepage/widgets/custom_profilecontainer.dart';
import 'package:langlex/presentation/screens/splashScreen/splashscreen.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_profile_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfilePage extends StatelessWidget {
  const ScreenProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolors.kbackgroundcolor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/profilebackground.jpeg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h(context) * .06,
                ),
                Container(
                  width: w(context) * .85,
                  height: h(context) * .22,
                  decoration: BoxDecoration(
                      color: Appcolors.kgreycolor,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(
                              255, 220, 213, 213), // Start color (bottom)
                          Appcolors.kwhiteColor, // End color (top)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5,
                          color: Appcolors.kgreenColor.withOpacity(.7))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: h(context) * .05,
                      ),
                      const CustomRoundImage(
                          circleContainerSize: 100,
                          imageUrl:
                              'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png'),
                      SizedBox(
                        width: h(context) * .05,
                      ),
                      Text('Ribinraj',
                          style: TextStyle(
                              fontSize: AppDimensions.fontSize20(context),
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h(context) * .05,
                      ),
                      InkWell(
                        onTap: () {
                          navigatePush(context, ScreenEditProfile());
                        },
                        child: const CustomProfileContainer(
                          containerText: 'Edit profile',
                          icon: CupertinoIcons.person,
                        ),
                      ),
                      SizedBox(
                        height: h(context) * .025,
                      ),
                      InkWell(
                        onTap: () {
                          navigatePush(context,ScreenLoginpage());
                        },
                        child: CustomProfileContainer(
                          containerText: 'My Courses',
                          icon: CupertinoIcons.briefcase,
                        ),
                      ),
                      SizedBox(
                        height: h(context) * .025,
                      ),
                      const CustomProfileContainer(
                        containerText: 'Packages',
                        icon: CupertinoIcons.collections,
                      ),
                      SizedBox(
                        height: h(context) * .025,
                      ),
                      const CustomProfileContainer(
                        containerText: 'Privacy & Policy',
                        icon: CupertinoIcons.exclamationmark_shield,
                      ),
                      SizedBox(
                        height: h(context) * .025,
                      ),
                      const CustomProfileContainer(
                        containerText: 'About Us',
                        icon: Icons.arrow_drop_down_circle_outlined,
                      ),
                      SizedBox(
                        height: h(context) * .025,
                      ),
                      InkWell(
                        onTap: () {
                          print('logout');
                          _logout(context);
                        },
                        child: Container(
                          height: h(context) * 0.065,
                          width: w(context) * 0.85,
                          decoration: BoxDecoration(
                              color: Appcolors.kbackgroundcolor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      Appcolors.kgreenColor.withOpacity(.7))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.logout_outlined,
                                  color: Appcolors.kredcolor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize:
                                          AppDimensions.fontSize18(context),
                                      fontWeight: FontWeight.w700,
                                      color: Appcolors.kredcolor),
                                ),
                                const Spacer(),
                                const Icon(
                                  CupertinoIcons.chevron_forward,
                                  color: Appcolors.kredcolor,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}

//////
Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('selectedLanguage');
  // After logging out, navigate back to the homepage
  navigatePushandRemoveuntil(
      context, SplashPage()); // Ensure that '/' route is Homepage
}
