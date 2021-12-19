import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/state.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';


void main() async
{
  WidgetsFlutterBinding
      .ensureInitialized(); //to be sure that every thing on the method done and then open the app

  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(
      const Size(
          600, 650
      ),
    );
  }

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();

  bool? isDark = CasheHelper.getData(key: 'isDark');


  isDark ??= false;

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({Key? key, required this.isDark,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness(),),
        BlocProvider(create: (context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        ),),
      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener : (context,state){},
        builder : (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}