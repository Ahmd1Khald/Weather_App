import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/state.dart';
import 'package:weather_app/network/remote/diohelper.dart';

import '../models/weather_model.dart';
import '../shared/constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  GetWeatherData? model;

  void getData({
    required String city,
    int days = 3,
  }) {
    emit(AppGetWeatherDateLoadingState());

    DioHelper.getData(
      url: url,
      query: {
        'q': city,
        'days': days,
        'aqi': 'no',
        'alerts': 'no',
      },
      key: key,
    ).then((value) {
      model = GetWeatherData.fromJson(value.data);
      print(model!.location.localtime);
      emit(AppGetWeatherDateSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetWeatherDateErrorState(model!));
    });
  }
}
