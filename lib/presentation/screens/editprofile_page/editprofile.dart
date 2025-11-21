import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/edit_profilemodel.dart';
import 'package:langlex/data/models/profile_model.dart';
import 'package:langlex/presentation/blocs/bloc/update_profile_bloc.dart';
import 'package:langlex/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';

import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';
import 'package:langlex/presentation/widgets/custom_imagepicker.dart';
import 'package:langlex/presentation/widgets/custom_squre_elevatedbutton.dart';
import 'package:langlex/presentation/widgets/custom_snakebar.dart';
import 'package:langlex/presentation/widgets/navigate_mainpage.dart';

class ScreenEditProfile extends StatefulWidget {
  final ProfileModel profile;

  const ScreenEditProfile({
    super.key,
    required this.profile,
  });

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  XFile? selectedimage;
  File? image;

  late TextEditingController usernameController;
  late TextEditingController phonenumberController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    usernameController =
        TextEditingController(text: widget.profile.userName ?? '');
    phonenumberController =
        TextEditingController(text: widget.profile.mobileNumber ?? '');
    emailController =
        TextEditingController(text: widget.profile.emailAddress ?? '');
  }

  @override
  void dispose() {
    usernameController.dispose();
    phonenumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    if (usernameController.text.isEmpty) {
      customSnackbar(
        context,
        'Please enter username',
        Appcolors.kprimarycolor,
      );
      return;
    }

    if (emailController.text.isEmpty) {
      customSnackbar(
        context,
        'Please enter email',
        Appcolors.kprimarycolor,
      );
      return;
    }

    if (phonenumberController.text.isEmpty) {
      customSnackbar(
        context,
        'Please enter phone number',
        Appcolors.kprimarycolor,
      );
      return;
    }

    // Validate image if selected
    if (image != null && !image!.existsSync()) {
      customSnackbar(
        context,
        'Selected image is invalid or has been deleted',
        Appcolors.kprimarycolor,
      );
      return;
    }

    final updatedProfile = EditProfileModel(
      userName: usernameController.text,
      emailAddress: emailController.text,
      mobileNumber: phonenumberController.text,
      image: image,
    );

    context.read<UpdateProfileBloc>().add(
      UpdateProfileButtonClickEvent(profile: updatedProfile),
    );
  }

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
          ),
        ),
        title: TextStyles.body(
          text: 'Edit Profile',
          color: Appcolors.kwhiteColor,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Appcolors.kprimarycolor,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .15,
            image: AssetImage(profilebackgroundimage),
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

                        return Hero(
                          tag: 'profile_image',
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Builder(
                                builder: (_) {
                                  if (image != null && image!.existsSync()) {
                                    return Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        log('Error loading image: $error');
                                        return _buildDefaultAvatar();
                                      },
                                    );
                                  }

                                  if (widget.profile.userPicture != null &&
                                      widget.profile.userPicture!.isNotEmpty) {
                                    return Image.network(
                                      "${Endpoints.baseprofileimageurl}${widget.profile.userPicture!}",
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildDefaultAvatar();
                                      },
                                    );
                                  }

                                  return _buildDefaultAvatar();
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 1,
                      child: InkWell(
                        onTap: () async {
                          try {
                            selectedimage =
                                await showBottomSheetWidget(context);
                            if (selectedimage != null) {
                              final pickedFile =
                                  File(selectedimage!.path);
                              
                              // Verify file exists before processing
                              if (!pickedFile.existsSync()) {
                                customSnackbar(
                                  context,
                                  'Image file not found',
                                  Appcolors.kprimarycolor,
                                );
                                return;
                              }

                              imagepickerbloc.add(
                                AddImageEvent(image: pickedFile),
                              );
                              log('Image selected: ${selectedimage!.path}');
                            }
                          } catch (e) {
                            log('Error picking image: $e');
                            customSnackbar(
                              context,
                              'Error picking image: $e',
                              Appcolors.kprimarycolor,
                            );
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
                      weight: FontWeight.w600,
                    ),
                    CustomEditingTextfield(
                      controller: usernameController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextStyles.body(
                      text: 'Phone number',
                      color: Appcolors.khinttextColor,
                      weight: FontWeight.w600,
                    ),
                    CustomEditingTextfield(
                      controller: phonenumberController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextStyles.body(
                      text: 'Email',
                      color: Appcolors.khinttextColor,
                      weight: FontWeight.w600,
                    ),
                    CustomEditingTextfield(
                      controller: emailController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                      listener: (context, state) {
                        if (state is UpdateProfileSuccessState) {
                          customSnackbar(
                            context,
                            state.message,
                            Appcolors.kprimarycolor,
                          );
                         
                        navigateToMainPage(context, 2);
                        } else if (state is UpdateProfileErrorState) {
                          customSnackbar(
                            context,
                            state.message,
                            Appcolors.kprimarycolor,
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading =
                            state is UpdateProfileLoadingState;

                        return CustomSqureElevatedButton(
                          onPressed: isLoading ? null : _updateProfile,
                          buttonText: "Update",
                          backgroundcolor: Appcolors.kprimarycolor,
                          isLoading: isLoading,
                        );
                      },
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

  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        size: 50,
        color: Colors.grey[600],
      ),
    );
  }
}