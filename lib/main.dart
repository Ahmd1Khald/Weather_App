import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/modules/home_screen.dart';
import 'package:weather_app/shared/constant.dart';
import 'bloc/bloc_obsever.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';
import 'network/remote/diohelper.dart';

void main() async {

  DioHelper.init();

  //onboard = null;
  late Widget widget;
  widget = HomeScreen();

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(
    this.widget,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: widget,
          );
        },
      ),
    );
  }
}
