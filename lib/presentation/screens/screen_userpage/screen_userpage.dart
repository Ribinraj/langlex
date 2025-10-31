// import 'package:flutter/material.dart';

// import 'package:langlex/core/colors.dart';
// import 'package:langlex/core/constants.dart';

// import 'package:langlex/presentation/screens/mainpages/widgets/bottom_navbar.dart';
// import 'package:langlex/presentation/screens/screen_student_registration/screen_registrationpage.dart';

// import 'package:langlex/presentation/widgets/custom_navigation.dart';
// import 'package:langlex/presentation/widgets/custom_registerbutton.dart';

// import 'package:langlex/presentation/widgets/custom_squre_elevatedbutton.dart';

// class ScreenUserpage extends StatefulWidget {
//   final String? userName;
//   const ScreenUserpage({super.key, this.userName});

//   @override
//   State<ScreenUserpage> createState() => _ScreenUserpageState();
// }

// class _ScreenUserpageState extends State<ScreenUserpage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       appBar: AppBar(
//         surfaceTintColor: Appcolors.kwhiteColor,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           'Student Lists',
//           style: TextStyle(
//             color: Color(0xFF2D3748),
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Username Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF667EEA).withOpacity(0.3),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     child: const Icon(
//                       Icons.person,
//                       size: 35,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     widget.userName ?? "Username",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Parent/Guardian',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             // Students Section Title
//             const Text(
//               'My Students',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF2D3748),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Student Cards
//             _buildStudentCard(
//                 name: 'Muhammed Akbar',
//                 className: 'Grade 8A',
//                 age: 14,
//                 school: 'St. Mary\'s High School',
//                 city: 'Malappuram',
//                 color: const Color(0xFF4299E1),
//                 onPressed: () {
//                   CustomNavigation.pushWithTransition(
//                       context, Screenmainpage());
//                 }),

//             const SizedBox(height: 16),

//             _buildStudentCard(
//                 name: 'Musthafa',
//                 className: 'Grade 6B',
//                 age: 12,
//                 school: 'Riverside Elementary',
//                 city: 'Los Angeles',
//                 color: const Color(0xFF48BB78),
//                 onPressed: () {
//                   CustomNavigation.pushWithTransition(
//                       context, Screenmainpage());
//                 }),

//             const SizedBox(height: 16),

//             _buildStudentCard(
//                 name: 'Annas muhammed',
//                 className: 'Grade 10A',
//                 age: 16,
//                 school: 'Lincoln High School',
//                 city: 'Chicago',
//                 color: const Color(0xFFED8936),
//                 onPressed: () {
//                   CustomNavigation.pushWithTransition(
//                       context, Screenmainpage());
//                 }),

//             const SizedBox(height: 30),

//             // Register Button
//             RegisterButton(
//               onPressed: () {
//                 CustomNavigation.pushWithTransition(
//                     context, ScreenStudentRegistration());
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStudentCard(
//       {required String name,
//       required String className,
//       required int age,
//       required String school,
//       required String city,
//       required Color color,
//       required void Function() onPressed}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.school,
//                   color: color,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2D3748),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       className,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: color,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           // Student Details
//           Row(
//             children: [
//               _buildDetailChip(Icons.cake, 'Age: $age', color),
//               const SizedBox(width: 12),
//               _buildDetailChip(Icons.location_city, city, color),
//             ],
//           ),

//           const SizedBox(height: 12),

//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.school_outlined,
//                   color: color,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     school,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: color,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ResponsiveSizedBox.height10,
//           CustomSqureElevatedButton(
//               height: 63,
//               onPressed: onPressed,
//               buttonText: 'Select & Continue',
//               backgroundcolor: Appcolors.kprimarycolor)
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailChip(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 6),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 12,
//               color: color,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:langlex/core/colors.dart';
import 'package:langlex/core/constants.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/student_list_model.dart';
import 'package:langlex/presentation/blocs/fetch_kids_bloc/fetch_kids_bloc_bloc.dart';
import 'package:langlex/presentation/blocs/verify_user_bloc/verify_user_bloc.dart';
import 'package:langlex/presentation/screens/languagepage/languagepage.dart';

import 'package:langlex/presentation/screens/screen_student_registration/screen_registrationpage.dart';
import 'package:langlex/presentation/widgets/custom_navigation.dart';
import 'package:langlex/presentation/widgets/custom_registerbutton.dart';
import 'package:langlex/presentation/widgets/custom_squre_elevatedbutton.dart';

class ScreenUserpage extends StatefulWidget {
  const ScreenUserpage({
    super.key,
  });

  @override
  State<ScreenUserpage> createState() => _ScreenUserpageState();
}

class _ScreenUserpageState extends State<ScreenUserpage> {
   String? userName;
  @override
  void initState() {
    super.initState();
    // Trigger the event to fetch kids when the screen initializes
    context.read<FetchKidsBlocBloc>().add(FetchKidsInitialEvent());
    final state = context.read<VerifyUserBloc>().state;
    if (state is VerifyUserSuccessState) {
      userName = state.userName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        surfaceTintColor: Appcolors.kwhiteColor,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Student Lists',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Fixed header section
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Username Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF667EEA).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: const Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userName?? "Username",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Parent/Guardian',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Students Section Title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'My Students',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: BlocBuilder<FetchKidsBlocBloc, FetchKidsBlocState>(
              builder: (context, state) {
                if (state is FetchKidsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF667EEA),
                      ),
                    ),
                  );
                } else if (state is FetchKidsErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.message}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<FetchKidsBlocBloc>()
                                .add(FetchKidsInitialEvent());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is FetchKidsSuccessState) {
                  final students = state.students;

                  if (students.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No students registered yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first student to get started',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildStudentCard(
                          student: student,
                          color: _getCardColor(index),
                          onPressed: () {
                            CustomNavigation.pushWithTransition(
                              context,
                              ScreenLanguagePage(
                                  selectedLanguages: student.languages),
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // Fixed register button at bottom
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: RegisterButton(
              onPressed: () {
                CustomNavigation.pushWithTransition(
                  context,
                  ScreenStudentRegistration(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getCardColor(int index) {
    final colors = [
      const Color(0xFF4299E1), // Blue
      const Color(0xFF48BB78), // Green
      const Color(0xFFED8936), // Orange
      const Color(0xFF9F7AEA), // Purple
      const Color(0xFFEC4899), // Pink
      const Color(0xFF10B981), // Emerald
    ];
    return colors[index % colors.length];
  }

  Widget _buildStudentCard({
    required StudentListModel student,
    required Color color,
    required void Function() onPressed,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: student.picture != null && student.picture!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${Endpoints.imagebaseUrl}${student.picture}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.person,
                                color: color,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.person,
                          color: color,
                          size: 30,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (student.languages.isNotEmpty)
                      Text(
                        student.languages
                            .map((lang) => lang.languageName)
                            .join(', '),
                        style: TextStyle(
                          fontSize: 14,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Student Details
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildDetailChip(Icons.cake, 'Age: ${student.age}', color),
              _buildDetailChip(Icons.location_city, student.city, color),
              _buildDetailChip(Icons.public, student.country, color),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.school_outlined,
                  color: color,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    student.school,
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ResponsiveSizedBox.height10,

          CustomSqureElevatedButton(
            height: 50,
            onPressed: onPressed,
            buttonText: 'Select & Continue',
            backgroundcolor: Appcolors.kprimarycolor,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
