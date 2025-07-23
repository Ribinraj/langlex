import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langlex/core/colors.dart';
import 'package:langlex/core/responsive_utils.dart';
import 'package:langlex/domain/repository/Datadownload_repository.dart';
import 'package:langlex/domain/repository/app_repo.dart';
import 'package:langlex/domain/repository/login_repo.dart';
import 'package:langlex/presentation/blocs/Content_download_bloc/content_download_bloc.dart';
import 'package:langlex/presentation/blocs/Fetch_data_from_database/fetchdata_from_database_bloc.dart';
import 'package:langlex/presentation/blocs/fetch_kids_bloc/fetch_kids_bloc_bloc.dart';
import 'package:langlex/presentation/blocs/fetch_languages_bloc/fetch_languages_bloc.dart';
import 'package:langlex/presentation/blocs/language_selection_bloc/languag_selection_bloc.dart';
import 'package:langlex/presentation/blocs/register_student_bloc/register_student_bloc.dart';
import 'package:langlex/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:langlex/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:langlex/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:langlex/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:langlex/presentation/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:langlex/presentation/blocs/quiz_answer_selection_bloc/qiuz_answer_selection_bloc.dart';
import 'package:langlex/presentation/blocs/user_register_bloc/user_register_bloc.dart';
import 'package:langlex/presentation/blocs/verify_user_bloc/verify_user_bloc.dart';
import 'package:langlex/presentation/cubits/language_change.dart';
import 'package:langlex/presentation/cubits/password_visiblity.dart';

import 'package:langlex/presentation/screens/screen_userpage/screen_userpage.dart';
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
    ResponsiveUtils().init(context);
    final loginrepo = Loginrepo();
    final apprepo = AppRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TogglepasswordCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider(create: (context) => QiuzAnswerSelectionBloc()),
        BlocProvider(
            create: (context) =>
                ContentDownloadBloc(repository: DownloadRepository())),
        BlocProvider(create: (context) => FetchdataFromDatabaseBloc()),
        BlocProvider(create: (context) => BottomNavigationBloc()),
        BlocProvider(create: (context) => ConnectivityBloc()),
        BlocProvider(create: (context) => SendOtpBloc(repository: loginrepo)),
        BlocProvider(
            create: (context) => VerifyUserBloc(repository: loginrepo)),
        BlocProvider(
            create: (context) => FetchLanguagesBloc(repository: apprepo)),
        BlocProvider(create: (context) => ResendOtpBloc(repository: loginrepo)),
        BlocProvider(
            create: (context) => UserRegisterBloc(repository: loginrepo)),
        BlocProvider(
            create: (context) => FetchKidsBlocBloc(repository: apprepo)),
        BlocProvider(
            create: (context) => RegisterStudentBloc(repository: apprepo)),
        BlocProvider(create: (context) => LanguageSelectionBloc()),
      ],
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, languageCode) {
          return LocaleBuilder(
            builder: (locale) => MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: Locales.delegates,
                supportedLocales: Locales.supportedLocales,
                locale: Locale(languageCode),
                title: 'LangLex',
                theme: ThemeData(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
                  useMaterial3: true,
                ),
                 home: const SplashPage()),
                //home: ScreenUserpage()),
          );
        },
      ),
    );
  }
}
