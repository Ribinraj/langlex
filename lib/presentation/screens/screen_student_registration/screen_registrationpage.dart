import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';

import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:langlex/presentation/blocs/language_selection_bloc/languag_selection_bloc.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editprofile.dart';
import 'package:langlex/presentation/screens/language_selectionpage/language_selectionpage.dart';
import 'package:langlex/presentation/screens/languagepage/languagepage.dart';
import 'package:langlex/presentation/widgets/custom_elevatedbutton.dart';
import 'package:langlex/presentation/widgets/custom_imagepicker.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';

import 'package:langlex/presentation/widgets/custom_snakebar.dart';

class ScreenStudentRegistration extends StatefulWidget {
  final List<Language>? selectedLanguages;
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
      duration: const Duration(milliseconds: 1500),
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
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
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

  void _registerStudent() {
    if (formKey.currentState!.validate()) {
      customSnackbar(
        context,
        'Student registered successfully!',
        Appcolors.kprimarycolor,
      );

      // Navigate or perform registration logic
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    } else {
      customSnackbar(
        context,
        'Please fill all required fields correctly',
        Appcolors.kredcolor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagepickerbloc = context.read<ImagePickerBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Custom Gradient Background with Paint Effects
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 43, 115, 94),
                      Color.fromARGB(255, 61, 144, 118),
                      Color.fromARGB(255, 116, 209, 191),
                      Color.fromARGB(255, 221, 229, 230),
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Floating Circles
          ...List.generate(6, (index) {
            return Positioned(
              left: (index % 2 == 0) ? -50 + (index * 80) : 50 + (index * 60),
              top: 100 + (index * 120),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationController.value * 2 * math.pi,
                    child: Container(
                      width: 60 + (index * 10),
                      height: 60 + (index * 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // Content
          SafeArea(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Header Section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student Registration',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(0, 2),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fill in the details below',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ResponsiveSizedBox.height20,

                  // Registration Form
                  SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar Section
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Center(
                            child: Stack(
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
                                      selectedimage =
                                          await showBottomSheetWidget(context);
                                      if (selectedimage != null) {
                                        imagepickerbloc.add(AddImageEvent(
                                            image: File(selectedimage!.path)));
                                        log(selectedimage.toString());
                                      }
                                    },
                                    child: const Icon(
                                      Icons.edit_square,
                                      color: Appcolors.kprimarycolor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ResponsiveSizedBox.height10,

                        // Name Field
                        _buildFieldLabel('Full Name'),
                        const SizedBox(height: 8),
                        CustomEditingTextfield(
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

                        const SizedBox(height: 20),

                        // Age Field
                        _buildFieldLabel('Age'),
                        const SizedBox(height: 8),
                        CustomEditingTextfield(
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

                        const SizedBox(height: 20),

                        // School Field
                        _buildFieldLabel('School'),
                        const SizedBox(height: 8),
                        CustomEditingTextfield(
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

                        const SizedBox(height: 20),

                        // City and Country Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('City'),
                                  const SizedBox(height: 8),
                                  CustomEditingTextfield(
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('Country'),
                                  const SizedBox(height: 8),
                                  CustomEditingTextfield(
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        ResponsiveSizedBox.height20,
                        InkWell(
                          onTap: () {
                            CustomNavigation.pushWithTransition(
                                context, LanguageSelectionPage());
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Appcolors.kwhiteColor),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent),
                            child: Row(
                              children: [
                                TextStyles.body(
                                    text: 'Select Languages',
                                    weight: FontWeight.bold,
                                    color: Appcolors.kwhiteColor),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: Appcolors.kwhiteColor,
                                ),
                                ResponsiveSizedBox.width10
                              ],
                            ),
                          ),
                        ),
                        ResponsiveSizedBox.height30,

                        // Register Button
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: CustomElevatedButton(
                            onPressed: _registerStudent,
                            buttonText: 'Register Student',
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Additional Info
                        Center(
                          child: Text(
                            'All fields are required',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.9),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Draw flowing curves
    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      0,
      size.height * 0.5,
    );
    path.close();

    canvas.drawPath(path, paint);

    // Draw another wave
    final path2 = Path();
    path2.moveTo(0, size.height * 0.7);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
