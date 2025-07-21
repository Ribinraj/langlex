// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';

// import 'package:langlex/core/responsive_utils.dart';
// import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';
// import 'package:langlex/presentation/blocs/language_selection_bloc/languag_selection_bloc.dart';
// import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';
// import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editprofile.dart';
// import 'package:langlex/presentation/screens/language_selectionpage/language_selectionpage.dart';
// import 'package:langlex/presentation/screens/languagepage/languagepage.dart';
// import 'package:langlex/presentation/widgets/custom_elevatedbutton.dart';
// import 'package:langlex/presentation/widgets/custom_imagepicker.dart';
// import 'package:langlex/presentation/widgets/custom_navigation.dart';

// import 'package:langlex/presentation/widgets/custom_snakebar.dart';

// class ScreenStudentRegistration extends StatefulWidget {
//   final List<int>? selectedLanguages;
//   const ScreenStudentRegistration({super.key, this.selectedLanguages});

//   @override
//   State<ScreenStudentRegistration> createState() =>
//       _ScreenStudentRegistrationState();
// }

// class _ScreenStudentRegistrationState extends State<ScreenStudentRegistration>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController schoolController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   XFile? selectedimage;
//   File? image;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     nameController.dispose();
//     ageController.dispose();
//     schoolController.dispose();
//     cityController.dispose();
//     countryController.dispose();
//     super.dispose();
//   }

//   // void _registerStudent() {
//   //   if (formKey.currentState!.validate() && selectedLanguages!) {
//   //     customSnackbar(
//   //       context,
//   //       'Student registered successfully!',
//   //       Appcolors.kprimarycolor,
//   //     );

//   //     // Navigate or perform registration logic
//   //     Future.delayed(const Duration(milliseconds: 500), () {
//   //       Navigator.pop(context);
//   //     });
//   //   } else {
//   //     customSnackbar(
//   //       context,
//   //       'Please fill all required fields correctly',
//   //       Appcolors.kredcolor,
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final imagepickerbloc = context.read<ImagePickerBloc>();
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           // Custom Gradient Background with Paint Effects
//           Positioned.fill(
//             child: CustomPaint(
//               painter: BackgroundPainter(),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color.fromARGB(255, 43, 115, 94),
//                       Color.fromARGB(255, 212, 242, 233),
//                       Color.fromARGB(255, 249, 250, 250),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                     stops: [0.0, 0.3, 0.7, 1.0],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Floating Circles
//           ...List.generate(6, (index) {
//             return Positioned(
//               left: (index % 2 == 0) ? -50 + (index * 80) : 50 + (index * 60),
//               top: 100 + (index * 120),
//               child: AnimatedBuilder(
//                 animation: _animationController,
//                 builder: (context, child) {
//                   return Transform.rotate(
//                     angle: _animationController.value * 2 * math.pi,
//                     child: Container(
//                       width: 60 + (index * 10),
//                       height: 60 + (index * 10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.1),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.2),
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }),

//           // Content
//           SafeArea(
//             child: Form(
//               key: formKey,
//               child: ListView(
//                 padding: const EdgeInsets.all(20),
//                 children: [
//                   // Header Section
//                   FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 10,
//                                 spreadRadius: 0,
//                               ),
//                             ],
//                           ),
//                           child: IconButton(
//                             onPressed: () => Navigator.pop(context),
//                             icon: const Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Student Registration',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   shadows: [
//                                     Shadow(
//                                       offset: const Offset(0, 2),
//                                       blurRadius: 4,
//                                       color: Colors.black.withOpacity(0.3),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Fill in the details below',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.white.withOpacity(0.8),
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   ResponsiveSizedBox.height20,

//                   // Registration Form
//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Avatar Section
//                         FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: Center(
//                             child: Stack(
//                               children: [
//                                 BlocBuilder<ImagePickerBloc, ImagePickerState>(
//                                   builder: (context, state) {
//                                     if (state is ImagePickedState) {
//                                       image = state.image;
//                                     }
//                                     return CustomEditprofileContainer(
//                                       circleContainerSize: 100,
//                                       imageFile: selectedimage?.path ?? '',
//                                     );
//                                   },
//                                 ),
//                                 Positioned(
//                                   bottom: 10,
//                                   right: 1,
//                                   child: InkWell(
//                                     onTap: () async {
//                                       selectedimage =
//                                           await showBottomSheetWidget(context);
//                                       if (selectedimage != null) {
//                                         imagepickerbloc.add(AddImageEvent(
//                                             image: File(selectedimage!.path)));
//                                         log(selectedimage.toString());
//                                       }
//                                     },
//                                     child: const Icon(
//                                       Icons.edit_square,
//                                       color: Appcolors.kprimarycolor,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         ResponsiveSizedBox.height10,

//                         // Name Field
//                         _buildFieldLabel('Full Name'),
//                         const SizedBox(height: 8),
//                         CustomEditingTextfield(
//                           controller: nameController,
//                           labelText: 'Enter your full name',
//                           textInputType: TextInputType.name,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your name';
//                             }
//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Age Field
//                         _buildFieldLabel('Age'),
//                         const SizedBox(height: 8),
//                         CustomEditingTextfield(
//                           controller: ageController,
//                           labelText: 'Enter your age',
//                           textInputType: TextInputType.number,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your age';
//                             }
//                             final age = int.tryParse(value);
//                             if (age == null || age < 5 || age > 100) {
//                               return 'Please enter a valid age (5-100)';
//                             }
//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // School Field
//                         _buildFieldLabel('School'),
//                         const SizedBox(height: 8),
//                         CustomEditingTextfield(
//                           controller: schoolController,
//                           labelText: 'Enter your school name',
//                           textInputType: TextInputType.text,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your school name';
//                             }
//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // City and Country Row
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildFieldLabel('City'),
//                                   const SizedBox(height: 8),
//                                   CustomEditingTextfield(
//                                     controller: cityController,
//                                     labelText: 'Enter city',
//                                     textInputType: TextInputType.text,
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter city';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildFieldLabel('Country'),
//                                   const SizedBox(height: 8),
//                                   CustomEditingTextfield(
//                                     controller: countryController,
//                                     labelText: 'Enter country',
//                                     textInputType: TextInputType.text,
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter country';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         ResponsiveSizedBox.height20,
//                         InkWell(
//                           onTap: () {
//                             CustomNavigation.pushWithTransition(
//                                 context, LanguageSelectionPage());
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                     width: 1, color: Appcolors.kwhiteColor),
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.transparent),
//                             child: Row(
//                               children: [
//                                 TextStyles.body(
//                                     text: 'Select Languages',
//                                     weight: FontWeight.bold,
//                                     color: Appcolors.kwhiteColor),
//                                 Spacer(),
//                                 Icon(
//                                   Icons.chevron_right,
//                                   color: Appcolors.kwhiteColor,
//                                 ),
//                                 ResponsiveSizedBox.width10
//                               ],
//                             ),
//                           ),
//                         ),
//                         ResponsiveSizedBox.height30,

//                         // Register Button
//                         FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: CustomElevatedButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate() &&
//                                   widget.selectedLanguages!.isNotEmpty) {}
//                             },
//                             buttonText: 'Register Student',
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // Additional Info
//                         Center(
//                           child: Text(
//                             'All fields are required',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFieldLabel(String label) {
//     return Text(
//       label,
//       style: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: Colors.white.withOpacity(0.9),
//       ),
//     );
//   }
// }

// class BackgroundPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withOpacity(0.05)
//       ..style = PaintingStyle.fill;

//     // Draw flowing curves
//     final path = Path();
//     path.moveTo(0, size.height * 0.2);
//     path.quadraticBezierTo(
//       size.width * 0.5,
//       size.height * 0.1,
//       size.width,
//       size.height * 0.3,
//     );
//     path.lineTo(size.width, size.height * 0.4);
//     path.quadraticBezierTo(
//       size.width * 0.5,
//       size.height * 0.3,
//       0,
//       size.height * 0.5,
//     );
//     path.close();

//     canvas.drawPath(path, paint);

//     // Draw another wave
//     final path2 = Path();
//     path2.moveTo(0, size.height * 0.7);
//     path2.quadraticBezierTo(
//       size.width * 0.3,
//       size.height * 0.8,
//       size.width,
//       size.height * 0.6,
//     );
//     path2.lineTo(size.width, size.height);
//     path2.lineTo(0, size.height);
//     path2.close();

//     canvas.drawPath(path2, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
/////////////////////////////////////////////////////
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/data/models/student_model.dart';

import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:langlex/presentation/blocs/register_student_bloc/register_student_bloc.dart';

import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editprofile.dart';
import 'package:langlex/presentation/screens/language_selectionpage/language_selectionpage.dart';
import 'package:langlex/presentation/screens/screen_student_registration/widgets/custom_dobpickerfield.dart';
import 'package:langlex/presentation/screens/screen_userpage/screen_userpage.dart';

import 'package:langlex/presentation/widgets/custom_imagepicker.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_registerbutton.dart';
import 'package:langlex/presentation/widgets/custom_registerloadingbutton.dart';
import 'package:langlex/presentation/widgets/custom_snakebar.dart';

class ScreenStudentRegistration extends StatefulWidget {
  final List<int>? selectedLanguages;
  const ScreenStudentRegistration({super.key, this.selectedLanguages});

  @override
  State<ScreenStudentRegistration> createState() =>
      _ScreenStudentRegistrationState();
}

class _ScreenStudentRegistrationState extends State<ScreenStudentRegistration>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  XFile? selectedimage;
  File? image;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    ageController.dispose();
    schoolController.dispose();
    cityController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagepickerbloc = context.read<ImagePickerBloc>();
    return Scaffold(
      backgroundColor: Appcolors.kwhiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Header Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildHeader(),
              ),

              const SizedBox(height: 30),

              // Registration Form Card
              SlideTransition(
                position: _slideAnimation,
                child: _buildRegistrationCard(imagepickerbloc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Appcolors.kprimarycolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 232, 248, 243),
                  border: Border.all(
                    color: const Color.fromARGB(255, 32, 181, 139),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Appcolors.kprimarycolor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Registration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kwhiteColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Create your student profile',
                      style: TextStyle(
                        fontSize: 14,
                        color: Appcolors.korangeColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress indicator
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Appcolors.kwhiteColor.withOpacity(0.8),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Appcolors.korangeColor),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Step 2 of 3',
            style: TextStyle(
              fontSize: 12,
              color: Appcolors.korangeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationCard(ImagePickerBloc imagepickerbloc) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.kwhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kgreycolor.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Section
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildAvatarSection(imagepickerbloc),
            ),

            const SizedBox(height: 30),

            // Form Fields
            _buildFormFields(),

            const SizedBox(height: 30),

            // Language Selection
            _buildLanguageSelection(),

            const SizedBox(height: 40),

            // Register Button
            FadeTransition(
              opacity: _fadeAnimation,
              child: BlocConsumer<RegisterStudentBloc, RegisterStudentState>(
                listener: (context, state) {
                  if (state is RegisterStudentSuccessState) {
                    CustomNavigation.pushReplaceWithTransition(
                        context, ScreenUserpage());
                    customSnackbar(
                      context,
                      state.message,
                      Appcolors.kprimarycolor,
                    );
                  } else if (state is RegisterStudentErrorState) {
                    customSnackbar(
                      context,
                      state.message,
                      Appcolors.kprimarycolor,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterStudentLoadingState) {
                    return const RegisterLoadingButton();
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: RegisterButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            widget.selectedLanguages != null) {
                          context.read<RegisterStudentBloc>().add(
                              RegisterStudentButtonClickEvent(
                                  student: StudentModel(
                                      name: nameController.text,
                                      age: int.parse(ageController.text),
                                      dob: dobController.text,
                                      school: schoolController.text,
                                      city: cityController.text,
                                      country: countryController.text,
                                      languageId:widget.selectedLanguages!)));
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Footer Text
            _buildFooterText(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(ImagePickerBloc imagepickerbloc) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Appcolors.kprimarycolor.withOpacity(0.1),
                  Appcolors.kgreenlightColor.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.kprimarycolor.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state is ImagePickedState) {
                  image = state.image;
                }
                return CustomEditprofileContainer(
                  circleContainerSize: 120,
                  imageFile: selectedimage?.path ?? '',
                );
              },
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Appcolors.kprimarycolor,
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.kprimarycolor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () async {
                  selectedimage = await showBottomSheetWidget(context);
                  if (selectedimage != null) {
                    imagepickerbloc
                        .add(AddImageEvent(image: File(selectedimage!.path)));
                    log(selectedimage.toString());
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Appcolors.kwhiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Name Field
        _buildAnimatedField(
          label: 'Full Name',
          child: CustomEditingTextfield(
            controller: nameController,
            labelText: 'Enter your full name',
            textInputType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          icon: Icons.person_outline,
        ),

        const SizedBox(height: 20),
        _buildAnimatedField(
          label: 'Date of Birth',
          child: DobPickerField(dobController: dobController),
          icon: Icons.calendar_today_outlined,
        ),
        const SizedBox(height: 20),
        // Age Field
        _buildAnimatedField(
          label: 'Age',
          child: CustomEditingTextfield(
            controller: ageController,
            labelText: 'Enter your age',
            textInputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              final age = int.tryParse(value);
              if (age == null || age < 5 || age > 100) {
                return 'Please enter a valid age (5-100)';
              }
              return null;
            },
          ),
          icon: Icons.calendar_today_outlined,
        ),

        const SizedBox(height: 20),

        // School Field
        _buildAnimatedField(
          label: 'School',
          child: CustomEditingTextfield(
            controller: schoolController,
            labelText: 'Enter your school name',
            textInputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your school name';
              }
              return null;
            },
          ),
          icon: Icons.school_outlined,
        ),

        const SizedBox(height: 20),

        // City and Country Row
        Row(
          children: [
            Expanded(
              child: _buildAnimatedField(
                label: 'City',
                child: CustomEditingTextfield(
                  controller: cityController,
                  labelText: 'Enter city',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                icon: Icons.location_city_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnimatedField(
                label: 'Country',
                child: CustomEditingTextfield(
                  controller: countryController,
                  labelText: 'Enter country',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter country';
                    }
                    return null;
                  },
                ),
                icon: Icons.public_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedField({
    required String label,
    required Widget child,
    required IconData icon,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Appcolors.kprimarycolor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Appcolors.ktextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: InkWell(
        onTap: () {
          CustomNavigation.pushWithTransition(
              context, const LanguageSelectionPage());
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Appcolors.kbackgroundcolor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Appcolors.kprimarycolor.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Appcolors.kprimarycolor.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Appcolors.kprimarycolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.language,
                  color: Appcolors.kprimarycolor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Languages',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Appcolors.ktextColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Choose your preferred languages',
                      style: TextStyle(
                        fontSize: 12,
                        color: Appcolors.khinttextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Appcolors.kprimarycolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: Appcolors.kprimarycolor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return const Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 14,
                color: Appcolors.khinttextColor,
              ),
              SizedBox(width: 4),
              Text(
                'All fields are required',
                style: TextStyle(
                  fontSize: 12,
                  color: Appcolors.khinttextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Your data is secure and encrypted',
            style: TextStyle(
              fontSize: 10,
              color: Appcolors.khinttextColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
