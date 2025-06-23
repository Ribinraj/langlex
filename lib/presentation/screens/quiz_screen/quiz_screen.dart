// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';
// import 'package:langlex/core/responsive_utils.dart';
// import 'package:langlex/presentation/blocs/quiz_answer_selection_bloc/qiuz_answer_selection_bloc.dart';

// import 'package:lottie/lottie.dart';
// import 'package:material_dialogs/dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:neopop/utils/color_utils.dart';
// import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

// class ScreenQuizPage extends StatefulWidget {
//   const ScreenQuizPage({super.key});

//   @override
//   State<ScreenQuizPage> createState() => _ScreenQuizPageState();
// }

// class _ScreenQuizPageState extends State<ScreenQuizPage> {
//   List<String> answerOptions = [
//     "Earth",
//     "Mars",
//     "Jupiter",
//     "Mercury",
//   ];
//   List<String> options = [
//     "A",
//     "B",
//     "C",
//     "D",
//   ];
//   int selectedOptionIndex = -1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             opacity: .15,
//             image: AssetImage(profilebackgroundimage),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//           child: Column(
//             children: [
//               ResponsiveSizedBox.height30,
//               Container(
//                 height: ResponsiveUtils.hp(5),
//                 width: ResponsiveUtils.wp(20),
//                 decoration: const BoxDecoration(
//                     color: Appcolors.kprimarycolor,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(100),
//                         topRight: Radius.circular(100))),
//                 child: Center(
//                   child: TextStyles.headline(
//                     text: '5',
//                     color: Appcolors.kwhiteColor,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: ResponsiveUtils.hp(40),
//                 // width: ResponsiveUtils.wp(40),
//                 decoration: BoxDecoration(
//                     color: Appcolors.kprimarycolor,
//                     borderRadius: BorderRadius.circular(50)),
//                 child: Padding(
//                   padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Text(
//                             'which planet is solar system is smallest ?',
//                             style: TextStyle(
//                                 color: Appcolors.kwhiteColor,
//                                 fontSize: ResponsiveUtils.wp(4.3),
//                                 fontWeight: FontWeight.bold),
//                             maxLines: null,
//                             overflow: TextOverflow.visible,
//                             softWrap: true,
//                           )),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(
//                             10), // Match border radius for clipping
//                         child: Image.asset(
//                           'assets/images/leopard.jpg',
//                           fit: BoxFit.cover,
//                           height: ResponsiveUtils.hp(20),
//                           // width: ResponsiveUtils.wp(40),
//                         ),
//                       ),
//                       ResponsiveSizedBox.height5,
//                     ],
//                   ),
//                 ),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: answerOptions.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onDoubleTap: () {
//                       Dialogs.materialDialog(
//                           color: Colors.white,
//                           msg: 'Your Answer is correct',
//                           titleStyle: TextStyle(
//                               color: Appcolors.korangBorderColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: ResponsiveUtils.hp(2.5)),
//                           msgStyle: TextStyle(
//                               color: Appcolors.kprimarycolor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: ResponsiveUtils.hp(2)),
//                           title: 'Congratulations',
//                           lottieBuilder: Lottie.asset(
//                             'assets/animations/Animation - 1727247389325.json',
//                             fit: BoxFit.contain,
//                           ),
//                           context: context,
//                           // ignore: deprecated_member_use
//                           actions: [
//                             IconsButton(
//                               onPressed: () {},
//                               text: 'Go to next',
//                               iconData: Icons.done,
//                               color: Appcolors.kprimarycolor,
//                               textStyle: const TextStyle(color: Colors.white),
//                               iconColor: Colors.white,
//                             ),
//                           ]);
//                     },
//                     onTap: () {
//                       // setState(() {
//                       //   selectedOptionIndex = index;
//                       // });
//                       context
//                           .read<QiuzAnswerSelectionBloc>()
//                           .add(SelectAnswerEvent(selectedIndex: index));
//                     },
//                     child: BlocBuilder<QiuzAnswerSelectionBloc,
//                         QiuzAnswerSelectionState>(
//                       builder: (context, state) {
//                         if (state is AnswerSelectedState) {
//                           selectedOptionIndex = state.selectedIndex;
//                         }
//                         return Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Container(
//                             padding: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: selectedOptionIndex == index
//                                   ? Appcolors.kgreenlightColor
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(50),
//                               border: Border.all(
//                                 color: selectedOptionIndex == index
//                                     ? Appcolors.kwhiteColor
//                                     : Appcolors.kprimarycolor,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                       color: selectedOptionIndex == index
//                                           ? Appcolors.kwhiteColor
//                                           : Appcolors.kgreenlightColor,
//                                       shape: BoxShape.circle),
//                                   child: Center(
//                                     child: Text(
//                                       options[index],
//                                       style: TextStyle(
//                                           color: selectedOptionIndex == index
//                                               ? Appcolors.kprimarycolor
//                                               : Appcolors.kwhiteColor,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                                 ResponsiveSizedBox.width10,
//                                 Text(
//                                   answerOptions[index],
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: selectedOptionIndex == index
//                                           ? Appcolors.kwhiteColor
//                                           : Appcolors.kprimarycolor),
//                                 ),
//                                 const Spacer(),
//                                 // Checkmark if selected
//                                 if (selectedOptionIndex == index)
//                                   const Icon(
//                                     Icons.check_circle,
//                                     color: Appcolors.kwhiteColor,
//                                   ),
//                                 ResponsiveSizedBox.width10,
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: NeoPopButton(
//                   color: Appcolors.kprimarycolor,

//                   bottomShadowColor:
//                       ColorUtils.getVerticalShadow(Appcolors.kgreycolor)
//                           .toColor(),
//                   rightShadowColor:
//                       ColorUtils.getHorizontalShadow(Appcolors.kgreycolor)
//                           .toColor(),
//                   border: Border.fromBorderSide(BorderSide(
//                     color: Appcolors.kwhiteColor,
//                     width: 1.5,
//                   )),

//                   onTapUp: () {
//                     HapticFeedback.vibrate();
//                     Dialogs.materialDialog(
//                         color: Colors.white,
//                         msg: 'Wrong Answer',
//                         titleStyle: TextStyle(
//                             color: Appcolors.korangBorderColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: ResponsiveUtils.hp(2)),
//                         msgStyle: TextStyle(
//                             color: Appcolors.kredcolor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: ResponsiveUtils.hp(1.5)),
//                         title: 'Sorry !!!',
//                         lottieBuilder: Lottie.asset(
//                           'assets/animations/Animation - 1727249749638.json',
//                           fit: BoxFit.contain,
//                         ),
//                         context: context,
//                         actions: [
//                           IconsButton(
//                             onPressed: () {},
//                             text: 'Go to next',
//                             iconData: Icons.done,
//                             color: Appcolors.kprimarycolor,
//                             textStyle: const TextStyle(color: Colors.white),
//                             iconColor: Colors.white,
//                           ),
//                         ]);
//                   },
//                   // onTapDown: () => HapticFeedback.vibrate(),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Submit',
//                           style: TextStyle(
//                               color: Appcolors.kwhiteColor,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
   
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/quiz_answer_selection_bloc/qiuz_answer_selection_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:neopop/utils/color_utils.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class ScreenQuizPage extends StatefulWidget {
  const ScreenQuizPage({super.key});

  @override
  State<ScreenQuizPage> createState() => _ScreenQuizPageState();
}

class _ScreenQuizPageState extends State<ScreenQuizPage>
    with TickerProviderStateMixin {
  List<String> answerOptions = [
    "Earth",
    "Mars",
    "Jupiter",
    "Mercury",
  ];
  List<String> options = [
    "A",
    "B",
    "C",
    "D",
  ];
  int selectedOptionIndex = -1;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _slideAnimation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Appcolors.kprimarycolor.withOpacity(0.1),
              Appcolors.kgreenlightColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
            child: Column(
              children: [
                // Progress Header
                _buildProgressHeader(),
                ResponsiveSizedBox.height30,
                
                // Question Card
                AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - _slideAnimation.value)),
                      child: Opacity(
                        opacity: _slideAnimation.value,
                        child: _buildQuestionCard(),
                      ),
                    );
                  },
                ),
                
                ResponsiveSizedBox.height20,
                
                // Answer Options
                _buildAnswerOptions(),
                
                ResponsiveSizedBox.height30,
                
                // Submit Button
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: selectedOptionIndex != -1 ? _pulseAnimation.value : 1.0,
                      child: _buildSubmitButton(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(6),
        vertical: ResponsiveUtils.hp(1),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kprimarycolor,
            Appcolors.kprimarycolor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kprimarycolor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.quiz,
                  color: Appcolors.kwhiteColor,
                  size: ResponsiveUtils.wp(5),
                ),
              ),
              ResponsiveSizedBox.width10,
              Text(
                'Question 5/10',
                style: TextStyle(
                  color: Appcolors.kwhiteColor,
                  fontSize: ResponsiveUtils.wp(4),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(3),
              vertical: ResponsiveUtils.hp(0.5),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '⏱️ 1:30',
              style: TextStyle(
                color: Appcolors.kwhiteColor,
                fontSize: ResponsiveUtils.wp(3.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Appcolors.kprimarycolor,
            Appcolors.kprimarycolor.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kprimarycolor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Question Text
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              'Which planet in our solar system is the smallest?',
              style: TextStyle(
                color: Appcolors.kwhiteColor,
                fontSize: ResponsiveUtils.wp(4.5),
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          ResponsiveSizedBox.height20,
          
          // Image Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/leopard.jpg',
                    fit: BoxFit.cover,
                    height: ResponsiveUtils.hp(22),
                    width: double.infinity,
                  ),
                  Container(
                    height: ResponsiveUtils.hp(22),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
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

  Widget _buildAnswerOptions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answerOptions.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                30 * (1 - _slideAnimation.value) * (index + 1),
              ),
              child: Opacity(
                opacity: _slideAnimation.value,
                child: _buildOptionTile(index),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOptionTile(int index) {
    return GestureDetector(
      onDoubleTap: () => _showResultDialog(true),
      onTap: () {
        HapticFeedback.lightImpact();
        context
            .read<QiuzAnswerSelectionBloc>()
            .add(SelectAnswerEvent(selectedIndex: index));
      },
      child: BlocBuilder<QiuzAnswerSelectionBloc, QiuzAnswerSelectionState>(
        builder: (context, state) {
          if (state is AnswerSelectedState) {
            selectedOptionIndex = state.selectedIndex;
          }
          
          bool isSelected = selectedOptionIndex == index;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.symmetric(
              vertical: ResponsiveUtils.hp(1),
              horizontal: ResponsiveUtils.wp(2),
            ),
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        Appcolors.kprimarycolor,
                        Appcolors.kprimarycolor.withOpacity(0.8),
                      ],
                    )
                  : null,
              color: isSelected ? null : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected 
                    ? Appcolors.kwhiteColor.withOpacity(0.5)
                    : Appcolors.kprimarycolor.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected 
                      ? Appcolors.kprimarycolor.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: isSelected ? 15 : 5,
                  offset: Offset(0, isSelected ? 8 : 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Option Letter Container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: ResponsiveUtils.wp(12),
                  width: ResponsiveUtils.wp(12),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [Colors.white, Colors.white.withOpacity(0.9)],
                          )
                        : LinearGradient(
                            colors: [
                              Appcolors.kgreenlightColor,
                              Appcolors.kgreenlightColor.withOpacity(0.8),
                            ],
                          ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isSelected 
                            ? Colors.white.withOpacity(0.5)
                            : Appcolors.kgreenlightColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      options[index],
                      style: TextStyle(
                        color: isSelected 
                            ? Appcolors.kprimarycolor
                            : Appcolors.kwhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveUtils.wp(4.5),
                      ),
                    ),
                  ),
                ),
                
                ResponsiveSizedBox.width10,
                
                // Answer Text
                Expanded(
                  child: Text(
                    answerOptions[index],
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(4.2),
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? Appcolors.kwhiteColor
                          : Appcolors.kprimarycolor,
                    ),
                  ),
                ),
                
                // Check Icon
                AnimatedScale(
                  scale: isSelected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(1)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Appcolors.kwhiteColor,
                      size: ResponsiveUtils.wp(6),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool canSubmit = selectedOptionIndex != -1;
    
    return AnimatedOpacity(
      opacity: canSubmit ? 1.0 : 0.6,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
        child: NeoPopButton(
          color: canSubmit ? Appcolors.kprimarycolor : Colors.grey,
          bottomShadowColor: ColorUtils.getVerticalShadow(
            canSubmit ? Appcolors.kprimarycolor : Colors.grey,
          ).toColor(),
          rightShadowColor: ColorUtils.getHorizontalShadow(
            canSubmit ? Appcolors.kprimarycolor : Colors.grey,
          ).toColor(),
          border: Border.all(
            color: Appcolors.kwhiteColor,
            width: 2,
          ),
          onTapUp: canSubmit ? () {
            HapticFeedback.mediumImpact();
            _showResultDialog(false);
          } : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(8),
              vertical: ResponsiveUtils.hp(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.send_rounded,
                  color: Appcolors.kwhiteColor,
                  size: ResponsiveUtils.wp(5),
                ),
                ResponsiveSizedBox.width10,
                Text(
                  'Submit Answer',
                  style: TextStyle(
                    color: Appcolors.kwhiteColor,
                    fontSize: ResponsiveUtils.wp(4.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(bool isCorrect) {
    Dialogs.materialDialog(
      color: Colors.white,
      msg: isCorrect ? 'Your Answer is correct!' : 'Wrong Answer - Try again!',
      titleStyle: TextStyle(
        color: Appcolors.korangBorderColor,
        fontWeight: FontWeight.bold,
        fontSize: ResponsiveUtils.hp(2.5),
      ),
      msgStyle: TextStyle(
        color: isCorrect ? Appcolors.kprimarycolor : Appcolors.kredcolor,
        fontWeight: FontWeight.w600,
        fontSize: ResponsiveUtils.hp(2),
      ),
      title: isCorrect ? 'Congratulations! 🎉' : 'Oops! 😔',
      lottieBuilder: Lottie.asset(
        isCorrect 
            ? 'assets/animations/Animation - 1727247389325.json'
            : 'assets/animations/Animation - 1727249749638.json',
        fit: BoxFit.contain,
      ),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: isCorrect ? 'Next Question' : 'Try Again',
          iconData: isCorrect ? Icons.arrow_forward : Icons.refresh,
          color: Appcolors.kprimarycolor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}