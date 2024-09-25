import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:langlex/presentation/blocs/quiz_answer_selection_bloc/qiuz_answer_selection_bloc.dart';
import 'package:langlex/presentation/cubits/language_change.dart';
import 'package:langlex/presentation/cubits/password_visiblity.dart';


import 'package:langlex/presentation/screens/splashScreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'hi', 'ka']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TogglepasswordCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(create: (context) => ImagePickerBloc(),
        ),
        BlocProvider(create: (context)=>QiuzAnswerSelectionBloc())
      ],
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, languageCode) {
          return LocaleBuilder(
            builder: (locale) => MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: Locale(languageCode), // Use the new language code here
              title: 'LangLex',
              theme: ThemeData(
                  fontFamily: 'Helvetica',
                  scaffoldBackgroundColor: Appcolors.kbackgroundcolor),
              home: SplashPage(),
            ),
          );
        },
      ),
    );
  }
}
