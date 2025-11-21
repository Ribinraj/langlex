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
import 'package:langlex/presentation/screens/screen_student_registration/widgets/formdatamanager.dart';
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
  final FormDataManager _formDataManager = FormDataManager();
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
    _restoreFormData();
  }

  void _restoreFormData() {
    if (_formDataManager.hasFormData()) {
      final data = _formDataManager.getFormData();
      nameController.text = data['name'] ?? '';
      ageController.text = data['age'] ?? '';
      schoolController.text = data['school'] ?? '';
      cityController.text = data['city'] ?? '';
      countryController.text = data['country'] ?? '';
      dobController.text = data['dob'] ?? '';

      // Restore image if exists
      if (data['imagePath'] != null && data['imagePath'].isNotEmpty) {
        selectedimage = XFile(data['imagePath']);
      }
    }
  }

  void _saveFormData() {
    _formDataManager.saveFormData(
      name: nameController.text,
      age: ageController.text,
      school: schoolController.text,
      city: cityController.text,
      country: countryController.text,
      dob: dobController.text,
      imagePath: selectedimage?.path,
    );
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
                  onPressed: () {
                    _formDataManager.clearFormData();
                    Navigator.pop(context);
                  },
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
                        color: Appcolors.kwhiteColor,
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
              backgroundColor: Appcolors.kgreycolor.withOpacity(0.8),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Appcolors.kwhiteColor),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Step 2 of 3',
            style: TextStyle(
              fontSize: 12,
              color: Appcolors.kwhiteColor,
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
                    _formDataManager.clearFormData();
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
                                      languageId: widget.selectedLanguages!,
                                      image: image)));
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
          child: DobPickerField(
              dobController: dobController,
              onDatePicked: (pickedDate) {
                final currentDate = DateTime.now();
                int age = currentDate.year - pickedDate.year;
                if (currentDate.month < pickedDate.month ||
                    (currentDate.month == pickedDate.month &&
                        currentDate.day < pickedDate.day)) {
                  age--; // Adjust if birthday hasn't occurred yet this year
                }
                  setState(() {
        ageController.text = age.toString();
      });
              }
              ),
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
          // Save form data before navigation
          _saveFormData();
          CustomNavigation.pushWithTransition(
              context, const LanguageSelectionPage());
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.selectedLanguages != null &&
                    widget.selectedLanguages!.isNotEmpty
                ? Appcolors.kgreenlightColor.withOpacity(0.1)
                : Appcolors.kbackgroundcolor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.selectedLanguages != null &&
                      widget.selectedLanguages!.isNotEmpty
                  ? Appcolors.kgreenlightColor
                  : Appcolors.kprimarycolor.withOpacity(0.3),
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
                  color: widget.selectedLanguages != null &&
                          widget.selectedLanguages!.isNotEmpty
                      ? Appcolors.kgreenlightColor.withOpacity(0.2)
                      : Appcolors.kprimarycolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.selectedLanguages != null &&
                          widget.selectedLanguages!.isNotEmpty
                      ? Icons.check_circle
                      : Icons.language,
                  color: widget.selectedLanguages != null &&
                          widget.selectedLanguages!.isNotEmpty
                      ? Appcolors.kgreenlightColor
                      : Appcolors.kprimarycolor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedLanguages != null &&
                              widget.selectedLanguages!.isNotEmpty
                          ? 'Languages Selected (${widget.selectedLanguages!.length}/3)'
                          : 'Select Languages',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Appcolors.ktextColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.selectedLanguages != null &&
                              widget.selectedLanguages!.isNotEmpty
                          ? 'Tap to change selection'
                          : 'Choose your preferred languages',
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
