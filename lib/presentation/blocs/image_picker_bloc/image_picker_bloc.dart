import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<ImagePickerEvent>((event, emit) {});
    on<AddImageEvent>(addimage);
  }

  FutureOr<void> addimage(AddImageEvent event, Emitter<ImagePickerState> emit) {
    emit(ImagePickedState(image: event.image));
  }
}
