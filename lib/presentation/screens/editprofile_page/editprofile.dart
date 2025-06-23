import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editprofile.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/language_selectionpage.dart';
import 'package:langlex/presentation/widgets/custom_imagepicker.dart';

class ScreenEditProfile extends StatefulWidget {
  const ScreenEditProfile({super.key});

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  XFile? selectedimage;
  File? image;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imagepickerbloc = context.read<ImagePickerBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Appcolors.kwhiteColor,
            )),
        title: TextStyles.body(
            text: 'Edit Profile',
            color: Appcolors.kwhiteColor,
            weight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Appcolors.kprimarycolor,
      ),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Stack(
                  children: [
                    BlocBuilder<ImagePickerBloc, ImagePickerState>(
                      builder: (context, state) {
                        if (state is ImagePickedState) {
                          image = state.image;
                        }
                        return CustomEditprofileContainer(
                          circleContainerSize: 100,
                          imageFile: selectedimage?.path ?? '',
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 1,
                      child: InkWell(
                        onTap: () async {
                          selectedimage = await showBottomSheetWidget(context);
                          if (selectedimage != null) {
                            imagepickerbloc.add(AddImageEvent(
                                image: File(selectedimage!.path)));
                            log(selectedimage.toString());
                          }
                        },
                        child: const Icon(
                          Icons.edit_square,
                          color: Appcolors.kblackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextStyles.body(
                        text: 'Username',
                        color: Appcolors.khinttextColor,
                        weight: FontWeight.w600),
                    CustomEditingTextfield(controller: usernameController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextStyles.body(
                        text: 'Phone number',
                        color: Appcolors.khinttextColor,
                        weight: FontWeight.w600),
                    CustomEditingTextfield(controller: phonenumberController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextStyles.body(
                        text: 'email',
                        color: Appcolors.khinttextColor,
                        weight: FontWeight.w600),
                    CustomEditingTextfield(controller: emailController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextStyles.body(
                        text: 'Password',
                        color: Appcolors.khinttextColor,
                        weight: FontWeight.w600),
                    CustomEditingTextfield(controller: passwordcController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      height: ResponsiveUtils.hp(6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Appcolors.kwhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                              color: Appcolors.kprimarycolor.withOpacity(0.5))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              TextStyles.body(
                                  text: 'Select languages',
                                  weight: FontWeight.w600,
                                  color: Appcolors.khinttextColor),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    showLanguageSelectionSheet(context);
                                  },
                                  icon: Icon(CupertinoIcons.chevron_down))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLanguageSelectionSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Enables full screen bottom sheet
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6, // Height when sheet is first displayed
        minChildSize: 0.3, // Minimum height the sheet can be dragged down to
        maxChildSize: 0.9, // Maximum height the sheet can be dragged up to
        expand: false, // Disable full screen expansion
        builder: (context, scrollController) {
          return LanguageSelectionSheet();
        },
      ),
    );
  }
}
