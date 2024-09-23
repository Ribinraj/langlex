import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super('en');

  void changeLanguage(String languageCode) {
    emit(languageCode);
  }
}