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
import 'package:langlex/presentation/widgets/navigate_mainpage.dart';
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
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ResponsiveUtils.hp(10),
                  ),
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                    // width: ResponsiveUtils.wp(80),
                    height: ResponsiveUtils.hp(22),
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
                            width: .5,
                            color: Appcolors.kgreenColor.withOpacity(.7))),
                    child: Row(
                      children: [
                        CustomRoundImage(
                            circleContainerSize: ResponsiveUtils.wp(20),
                            imageUrl:
                                'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png'),
                        ResponsiveSizedBox.width30,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextStyles.body(
                              text: 'Ribinraj',
                              weight: FontWeight.bold,
                            ),
                            ResponsiveSizedBox.height5,
                            TextStyles.caption(
                              text: 'ribinrajop@gmail.com',
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ResponsiveSizedBox.height50,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          CustomNavigation.push(context, ScreenEditProfile());
                        },
                        child: const CustomProfileContainer(
                          containerText: 'Edit profile',
                          icon: CupertinoIcons.person,
                        ),
                      ),
                      ResponsiveSizedBox.height20,
                      InkWell(
                        onTap: () {
                          CustomNavigation.push(context, ScreenQuizPage());
                        },
                        child: CustomProfileContainer(
                          containerText: 'My Courses',
                          icon: CupertinoIcons.briefcase,
                        ),
                      ),
                      ResponsiveSizedBox.height20,
                      const CustomProfileContainer(
                        containerText: 'Packages',
                        icon: CupertinoIcons.collections,
                      ),
                      ResponsiveSizedBox.height20,
                      const CustomProfileContainer(
                        containerText: 'Privacy & Policy',
                        icon: CupertinoIcons.exclamationmark_shield,
                      ),
                      ResponsiveSizedBox.height20,
                      const CustomProfileContainer(
                        containerText: 'About Us',
                        icon: Icons.arrow_drop_down_circle_outlined,
                      ),
                      ResponsiveSizedBox.height20,
                      InkWell(
                        onTap: () {
                          print('logout');
                          _logout(context);
                        },
                        child: Container(
                          height: ResponsiveUtils.hp(6),
                          // width: ResponsiveUtils.wp(80),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 235, 228,
                                      228), // Start color (bottom)
                                  Appcolors.kwhiteColor, // End color (top)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(5),
                              // borderRadius: const BorderRadius.only(
                              //     topLeft: Radius.circular(15),
                              //     bottomRight: Radius.circular(15)),
                              border: Border.all(
                                  width: .5,
                                  color:
                                      Appcolors.kgreenColor.withOpacity(.7))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.logout_outlined,
                                  color: Appcolors.kredcolor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextStyles.medium(
                                    text: 'Logout',
                                    weight: FontWeight.bold,
                                    color: Appcolors.kredcolor),
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
                  )
                ],
              ),
            )
          ],
        ));
  }
}

//////
Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('selectedLanguage');
  navigateToMainPage(context, 0);
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const SplashPage()),
    (route) => false,
  );
}
