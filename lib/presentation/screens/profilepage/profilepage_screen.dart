// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/core/responsive_utils.dart';

// import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';

// import 'package:langlex/presentation/screens/profilepage/widgets/custom_profilecontainer.dart';
// import 'package:langlex/presentation/screens/quiz_screen/quiz_screen.dart';
// import 'package:langlex/presentation/screens/splashScreen/splashscreen.dart';
// import 'package:langlex/presentation/widgets/custom_navigation.dart';

// import 'package:langlex/presentation/widgets/custom_profile_image.dart';
// import 'package:langlex/presentation/widgets/navigate_mainpage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScreenProfilePage extends StatelessWidget {
//   const ScreenProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Appcolors.kbackgroundcolor,
//         body: Stack(
//           children: [
//             Positioned.fill(
//               child: Opacity(
//                 opacity: 0.15,
//                 child: Image.asset(
//                   'assets/images/profilebackground.jpeg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: ResponsiveUtils.hp(10),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                     // width: ResponsiveUtils.wp(80),
//                     height: ResponsiveUtils.hp(22),
//                     decoration: BoxDecoration(
//                       color: Appcolors.kgreycolor,
//                       gradient: const LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color.fromARGB(
//                               255, 220, 213, 213),
//                           Appcolors.kwhiteColor,
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                       // border: Border.all(
//                       //     width: .5,
//                       //     color: Appcolors.kgreenColor.withOpacity(.7))
//                     ),
//                     child: Row(
//                       children: [
//                         CustomRoundImage(
//                             circleContainerSize: ResponsiveUtils.wp(20),
//                             imageUrl:
//                                 'https://w7.pngwing.com/pngs/878/170/png-transparent-student-cartoon-kids-child-people-reading-thumbnail.png'),
//                         ResponsiveSizedBox.width30,
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextStyles.body(
//                               text: 'Ribinraj',
//                               weight: FontWeight.bold,
//                             ),
//                             ResponsiveSizedBox.height5,
//                             TextStyles.caption(
//                               text: 'ribinrajop@gmail.com',
//                               weight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   ResponsiveSizedBox.height30,
//                   Container(
//                     padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Appcolors.kwhiteColor,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             CustomNavigation.push(context, ScreenEditProfile());
//                           },
//                           child: const CustomProfileContainer(
//                             containerText: 'Edit profile',
//                             icon: CupertinoIcons.person,
//                           ),
//                         ),
//                         ResponsiveSizedBox.height20,
//                         InkWell(
//                           onTap: () {
//                             CustomNavigation.push(context, ScreenQuizPage());
//                           },
//                           child: CustomProfileContainer(
//                             containerText: 'My Courses',
//                             icon: CupertinoIcons.briefcase,
//                           ),
//                         ),
//                         ResponsiveSizedBox.height20,
//                         const CustomProfileContainer(
//                           containerText: 'Packages',
//                           icon: CupertinoIcons.collections,
//                         ),
//                         ResponsiveSizedBox.height20,
//                         const CustomProfileContainer(
//                           containerText: 'Privacy & Policy',
//                           icon: CupertinoIcons.exclamationmark_shield,
//                         ),
//                         ResponsiveSizedBox.height20,
//                         const CustomProfileContainer(
//                           containerText: 'About Us',
//                           icon: Icons.arrow_drop_down_circle_outlined,
//                         ),
//                         ResponsiveSizedBox.height20,
//                         InkWell(
//                           onTap: () {
//                             print('logout');
//                             _logout(context);
//                           },
//                           child: Container(
//                             height: ResponsiveUtils.hp(6),
//                             // width: ResponsiveUtils.wp(80),
//                             decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Color.fromARGB(255, 235, 228,
//                                         228), // Start color (bottom)
//                                     Appcolors.kwhiteColor, // End color (top)
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(5),
//                                 // borderRadius: const BorderRadius.only(
//                                 //     topLeft: Radius.circular(15),
//                                 //     bottomRight: Radius.circular(15)),
//                                 border: Border.all(
//                                     width: .5,
//                                     color:
//                                         Appcolors.kgreenColor.withOpacity(.7))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 12, right: 12),
//                               child: Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.logout_outlined,
//                                     color: Appcolors.kredcolor,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   TextStyles.medium(
//                                       text: 'Logout',
//                                       weight: FontWeight.bold,
//                                       color: Appcolors.kredcolor),
//                                   const Spacer(),
//                                   const Icon(
//                                     CupertinoIcons.chevron_forward,
//                                     color: Appcolors.kredcolor,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }

// //////
// Future<void> _logout(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('selectedLanguage');
//   navigateToMainPage(context, 0);
//   Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (context) => const SplashPage()),
//     (route) => false,
//   );
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/screens/editprofile_page/editprofile.dart';
import 'package:langlex/presentation/screens/quiz_screen/quiz_screen.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

import 'package:langlex/presentation/widgets/custom_profile_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfilePage extends StatelessWidget {
  const ScreenProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      body: Column(
        children: [
          // Top Profile Section with Wave Background
          Stack(
            children: [
              Container(
                height: ResponsiveUtils.hp(35),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.kgreenColor,
                      Color.fromARGB(255, 99, 233, 179)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(6),
                    vertical: ResponsiveUtils.hp(6)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile and Menu Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRoundImage(
                          circleContainerSize: ResponsiveUtils.wp(25),
                          imageUrl:
                              'https://anakoskaphotography.com/wp-content/uploads/2018/09/outdoor-children-photo-of-a-girl.jpg',
                        ),
                        GestureDetector(
                          onTap: () {
                            CustomNavigation.push(
                                context, const ScreenEditProfile());
                          },
                          child: const Icon(Icons.edit_square,
                              color: Colors.white, size: 25),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveUtils.hp(2)),
                    TextStyles.subheadline(
                        text: 'Ribinraj',
                        weight: FontWeight.bold,
                        color: Appcolors.kwhiteColor),
                    ResponsiveSizedBox.height5,
                    TextStyles.caption(
                        text: 'ribinrajop@gmail.com',
                        weight: FontWeight.bold,
                        color: Appcolors.kwhiteColor),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.hp(5)),

          // Category Grid Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(5)),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> categories = [
                    {
                      'icon': CupertinoIcons.briefcase,
                      'label': "My Courses",
                      'page': const ScreenEditProfile()
                    },
                    {
                      'icon': CupertinoIcons.collections,
                      'label': "Packages",
                      'page': const ScreenQuizPage()
                    },
                    {
                      'icon': CupertinoIcons.exclamationmark_shield,
                      'label': "Privacy Policy"
                    },
                    {
                      'icon': Icons.arrow_drop_down_circle_outlined,
                      'label': "About Us"
                    },
                    {'icon': Icons.format_paint, 'label': "Conditions"},
                    {'icon': Icons.air, 'label': "Dry"},
                  ];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => categories[index]['page']),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.redAccent.withOpacity(0.5),
                            width: 1.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categories[index]['icon'],
                            size: ResponsiveUtils.wp(6),
                            color: Colors.redAccent.withOpacity(.6),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categories[index]['label'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Logout Button
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(5),
                    vertical: ResponsiveUtils.hp(3)),
                child: ElevatedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Logout",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.wp(1),
                        horizontal: ResponsiveUtils.wp(4)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Logout Function
Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('selectedLanguage');
  Navigator.pushReplacementNamed(context, '/splash');
}
