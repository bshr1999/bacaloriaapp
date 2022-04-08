
import 'package:arena/module/home/home_screen.dart';
import 'package:arena/module/subjects_screen/subjects_screen.dart';
import 'package:arena/shared/local/constant.dart';
import 'package:arena/shared/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';
import 'module/home/home_cubit.dart';
import 'module/home/home_states.dart';
import 'module/start_screen/start.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  DioHelper.initSubDio();
  // var uuid=Uuid();
  // for(int i=1;i<10;i++){
  //   DioHelper.postData(
  //       apiKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs',
  //       baseUrl: 'https://uuswpiqmnxmpjoyjktfa.supabase.co/rest/v1/uid',
  //       data: {
  //         "uid":uuid.v1(),
  //       },
  //       authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1c3dwaXFtbnhtcGpveWprdGZhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY0ODgxODE2NywiZXhwIjoxOTY0Mzk0MTY3fQ.lsgTxihoXlpl0Qj4fv2mtmStO9xBvEWrUsn3qtXwkYs'
  //   ).then((value) {
  //     print(value.data);
  //   }).catchError((error){print(error.toString());});
  // }

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>HomeCubit()..getDataSupabase()..getSubjectDetails(context: context),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
            ],
            locale: const Locale("ar", "AE"),// OR Locale('ar', 'AE') OR Other RTL locales,,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: HexColor('#4d0303'),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('#4d0303'),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 1.0,
                selectedItemColor: HexColor('#4d0303'),
                selectedIconTheme: IconThemeData(
                  color: HexColor('#4d0303'),
                ),
                selectedLabelStyle: TextStyle(
                  color: HexColor('#4d0303'),
                ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey
            ),
            primaryColor: HexColor('#4d0303'),
            focusColor: HexColor('#4d0303'),
            accentColor: HexColor('#4d0303'),
            colorScheme:ThemeData().colorScheme.copyWith(
              secondary: HexColor('#4d0303'),
            ),
          ),
          home:  const HomeScreen(),
        );},
      ),
    );
  }
}
