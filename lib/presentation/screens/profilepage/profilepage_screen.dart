import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';

import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';

import 'package:langlex/presentation/screens/profilepage/widgets/custom_profilecontainer.dart';
import 'package:langlex/presentation/screens/quiz_screen/quiz_screen.dart';
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
               ResponsiveSizedBox.height10,
                Container(
                  width: ResponsiveUtils.hp(.2),
                  height:  ResponsiveUtils.wp(22),
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
                    ResponsiveSizedBox.height10,
                      const CustomRoundImage(
                          circleContainerSize: 100,
                          imageUrl:
                              'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png'),
                     ResponsiveSizedBox.height10,
                      TextStyles.body(text: 'Ribinraj',
                      weight: FontWeight.bold,

                        ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     ResponsiveSizedBox.height10,
                      InkWell(
                        onTap: () {
                          navigatePush(context, ScreenEditProfile());
                        },
                        child: const CustomProfileContainer(
                          containerText: 'Edit profile',
                          icon: CupertinoIcons.person,
                        ),
                      ),
                    ResponsiveSizedBox.height10,
                      InkWell(
                        onTap: () {
                          navigatePush(context, ScreenQuizPage());
                        },
                        child: CustomProfileContainer(
                          containerText: 'My Courses',
                          icon: CupertinoIcons.briefcase,
                        ),
                      ),
                     ResponsiveSizedBox.height10,
                      const CustomProfileContainer(
                        containerText: 'Packages',
                        icon: CupertinoIcons.collections,
                      ),
                    ResponsiveSizedBox.height10,
                      const CustomProfileContainer(
                        containerText: 'Privacy & Policy',
                        icon: CupertinoIcons.exclamationmark_shield,
                      ),
                     ResponsiveSizedBox.height10,
                      const CustomProfileContainer(
                        containerText: 'About Us',
                        icon: Icons.arrow_drop_down_circle_outlined,
                      ),
                     ResponsiveSizedBox.height10,
                      InkWell(
                        onTap: () {
                          print('logout');
                          _logout(context);
                        },
                        child: Container(
                          height:  ResponsiveUtils.hp(2),
                          width: ResponsiveUtils.wp(2),
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
                                TextStyles.medium(
                                 text:  'Logout',
                                weight: FontWeight.bold,
                                color: Appcolors.kredcolor
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
