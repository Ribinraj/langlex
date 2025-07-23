import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting
import 'package:langlex/core/colors.dart';
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';


class DobPickerField extends StatefulWidget {
  final void Function(DateTime) onDatePicked;
  final TextEditingController dobController;
  const DobPickerField({super.key, required this.dobController, required this.onDatePicked});

  @override
  State<DobPickerField> createState() => _DobPickerFieldState();
}

class _DobPickerFieldState extends State<DobPickerField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2009),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
          builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Appcolors.kprimarycolor,        // Header background, selected date
            onPrimary: Colors.white,                 // Text on selected date
            surface: Colors.white,                   // Background of the dialog
            onSurface: Appcolors.ktextColor,         // Default text color
            secondary: Appcolors.korangeColor,    // Optional: accent color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Appcolors.kprimarycolor, // Button text
            ),
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
        widget.onDatePicked(picked); // 👉 Call the parent callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer( // prevents keyboard from appearing
        child: CustomEditingTextfield(
          controller: widget.dobController,
          labelText: 'Date of Birth',
          textInputType: TextInputType.none,
          suffixIcon: const Icon(Icons.calendar_today),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),
      ),
    );
  }
}
