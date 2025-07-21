import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting
import 'package:langlex/presentation/screens/editprofile_page/widgets/custom_editing_textfield.dart';


class DobPickerField extends StatefulWidget {
  final TextEditingController dobController;
  const DobPickerField({super.key, required this.dobController});

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
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
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
