import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_app/modules/home_screen.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/login_cubit.dart';
import 'package:social_app/shared/cubit/register_cubit.dart';
import 'components/constants.dart';
import 'l10n/l10n.dart';
import 'modules/login_screen.dart';
import 'network/cache_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if(uId != null){
    widget= Home();
  }
  else{
    widget= Login();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => LoginCubit()),
          BlocProvider(create: (BuildContext context) => RegisterCubit()),
          BlocProvider(create: (BuildContext context) => AppCubit()..getUsers()),

        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.grey),
              color: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              //ya3ny kol wa7da ta7tha kelma
              type: BottomNavigationBarType.fixed,
              elevation: 20.0,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
            )
          ),
         supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          home: startWidget,
          builder: EasyLoading.init(),
        ));
  }
}


