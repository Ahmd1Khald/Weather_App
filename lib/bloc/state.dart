import '../models/weather_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeObscureIconState extends AppStates {}

class AppChangeBottomIndexState extends AppStates {}

class AppGetWeatherDateLoadingState extends AppStates {}

class AppGetWeatherDateSuccessState extends AppStates {}

class AppGetWeatherDateErrorState extends AppStates {
  final GetWeatherData model;

  AppGetWeatherDateErrorState(this.model);
}
