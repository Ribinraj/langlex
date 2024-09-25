import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/presentation/blocs/quiz_answer_selection_bloc/qiuz_answer_selection_bloc.dart';
import 'package:langlex/presentation/screens/homepage/widgets/custom_appbar.dart';

import 'package:langlex/presentation/widgets/custom_elevatedbutton.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class ScreenQuizPage extends StatefulWidget {
  const ScreenQuizPage({super.key});

  @override
  State<ScreenQuizPage> createState() => _ScreenQuizPageState();
}

class _ScreenQuizPageState extends State<ScreenQuizPage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .15,
            image: AssetImage(
                profilebackgroundimage), // Correct way to use asset image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: h(context) * .06,
              ),
              Container(
                height: h(context) * .07,
                width: w(context) * .35,
                decoration: const BoxDecoration(
                    color: Appcolors.kgreenColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100))),
                child: Center(
                  child: Text(
                    '5',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kwhiteColor,
                        fontSize: AppDimensions.fontSize30(context)),
                  ),
                ),
              ),
              Container(
                height: h(context) * .37,
                width: w(context) * .9,
                decoration: BoxDecoration(
                    color: Appcolors.kgreenColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'which planet is solar system is smallest ?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Appcolors.kwhiteColor,
                                fontSize: AppDimensions.fontSize20(context)),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Match border radius for clipping
                        child: Image.asset(
                          'assets/images/leopard.jpg',
                          fit: BoxFit.cover,
                          height: h(context) * .2,
                          width: w(context) * .5,
                        ),
                      ),
                      SizedBox(
                        height: h(context) * .03,
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: answerOptions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      Dialogs.materialDialog(
                          color: Colors.white,
                          msg: 'Your Answer is correct',
                          titleStyle: TextStyle(
                              color: Appcolors.korangBorderColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.fontSize24(context)),
                          msgStyle: TextStyle(
                              color: Appcolors.kgreenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.fontSize18(context)),
                          title: 'Congratulations',
                          lottieBuilder: Lottie.asset(
                            'assets/animations/Animation - 1727247389325.json',
                            fit: BoxFit.contain,
                          ),
                          context: context,
                          // ignore: deprecated_member_use
                          actions: [
                            IconsButton(
                              onPressed: () {},
                              text: 'Go to next',
                              iconData: Icons.done,
                              color: Appcolors.kgreenColor,
                              textStyle: const TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ]);
                    },
                    onTap: () {
                      // setState(() {
                      //   selectedOptionIndex = index;
                      // });
                      context
                          .read<QiuzAnswerSelectionBloc>()
                          .add(SelectAnswerEvent(selectedIndex: index));
                    },
                    child: BlocBuilder<QiuzAnswerSelectionBloc,
                        QiuzAnswerSelectionState>(
                      builder: (context, state) {
                        if (state is AnswerSelectedState) {
                          selectedOptionIndex = state.selectedIndex;
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: selectedOptionIndex == index
                                  ? Appcolors.kgreenlightColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: selectedOptionIndex == index
                                    ? Appcolors.kwhiteColor
                                    : Appcolors.kgreenColor,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: selectedOptionIndex == index
                                          ? Appcolors.kwhiteColor
                                          : Appcolors.kgreenlightColor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      options[index],
                                      style: TextStyle(
                                          color: selectedOptionIndex == index
                                              ? Appcolors.kgreenColor
                                              : Appcolors.kwhiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: w(context) * .07,
                                ),
                                Text(
                                  answerOptions[index],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: selectedOptionIndex == index
                                          ? Appcolors.kwhiteColor
                                          : Appcolors.kgreenColor),
                                ),
                                const Spacer(),
                                // Checkmark if selected
                                if (selectedOptionIndex == index)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Appcolors.kwhiteColor,
                                  ),
                                SizedBox(
                                  width: w(context) * .02,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              CustomElevatedButton(
                onPressed: () {
                  Dialogs.materialDialog(
                      color: Colors.white,
                      msg: 'Wrong Answer',
                      titleStyle: TextStyle(
                          color: Appcolors.korangBorderColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.fontSize24(context)),
                      msgStyle: TextStyle(
                          color: Appcolors.kredcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.fontSize18(context)),
                      title: 'Sorry !!!',
                      lottieBuilder: Lottie.asset(
                        'assets/animations/Animation - 1727249749638.json',
                        fit: BoxFit.contain,
                      ),
                      context: context,
                      actions: [
                        IconsButton(
                          onPressed: () {},
                          text: 'Go to next',
                          iconData: Icons.done,
                          color: Appcolors.kgreenColor,
                          textStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                        ),
                      ]);
                },
                buttonText: 'Submit',
                backgroundcolor: Appcolors.kgreenColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
