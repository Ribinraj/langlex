part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickedState extends ImagePickerState {
  final File image;

  ImagePickedState({required this.image});
}
