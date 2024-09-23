import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langlex/core/colors.dart';

class TogglepasswordCubit extends Cubit<bool> {
  TogglepasswordCubit() : super(true);

  void togglePassword() {
    emit(!state);
  }
}
////
Widget togglePassword() {
    return BlocBuilder<TogglepasswordCubit, bool>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<TogglepasswordCubit>().togglePassword();
          },
          icon: state
              ? const Icon(
                  Icons.visibility,
                  color:Appcolors.korangeColor,
                )
              : const Icon(
                  Icons.visibility_off,
                  color:Appcolors.korangeColor,
                ),
        );
      },
    );
  }