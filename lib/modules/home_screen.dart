import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/bloc/cubit.dart';
import 'package:weather_app/bloc/state.dart';
import 'package:weather_app/shared/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  String? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetWeatherDateErrorState) {
          myToast(state: 'Try Another City', toastState: toastState.Error);
        }
        if (state is AppGetWeatherDateSuccessState) {
          myToast(state: 'Done!', toastState: toastState.Success);
        }
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        AppCubit model = AppCubit.get(context);
        return Scaffold(
          backgroundColor: HexColor('172933'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.75,
                  width: size.width,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          HexColor('9CC4DF'),
                          HexColor('1475B8'),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.2, 0.85]),
                    borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(50),
                        bottomStart: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (value) {
                            AppCubit.get(context).getData(city: value);
                          },
                          decoration: InputDecoration(
                            label: const Text('Write City'),
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      if (state is AppGetWeatherDateLoadingState)
                        circleLoading(color: Colors.white),
                      ConditionalBuilder(
                        condition: state is AppGetWeatherDateSuccessState,
                        builder: (context) {
                          image = model.model!.current.condition.icon;
                          image = image!.substring(2, image!.length);
                          return Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    model.model!.current.condition.text,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.amber,
                                        fontSize: 28),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image(
                                            image: AssetImage(image!),
                                            width: 60),
                                      ),
                                      Text(
                                        model.model!.location.name,
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Image(
                                            image: AssetImage(image!),
                                            width: 60),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    model.model!.location.region,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    model.model!.location.tzId,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    model.model!.location.localtime,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    model.model!.current.tempC.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                  const Text(
                                    'C',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 32),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      width: 3,
                                      height: 35,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    model.model!.current.tempF.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                  const Text(
                                    'F',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 32),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                        fallback: (context) => const Opacity(
                            opacity: 0.7,
                            child: Image(
                                image: AssetImage(
                              'images/Earth.png',
                            ))),
                      ),
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: state is AppGetWeatherDateSuccessState,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Wind Speed(MPH)',
                                  style: TextStyle(
                                      color: HexColor('F0C446'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  model.model!.current.windMph.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Gust(MPH)',
                                  style: TextStyle(
                                      color: HexColor('F0C446'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  model.model!.current.gustMph.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Wind Direction',
                                  style: TextStyle(
                                      color: HexColor('F0C446'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  model.model!.current.windDir.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: 220,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Pressure(MB)',
                                  style: TextStyle(
                                      color: HexColor('F0C446'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  model.model!.current.pressureMb.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Humidity',
                                  style: TextStyle(
                                      color: HexColor('F0C446'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  model.model!.current.humidity.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Wind Speed(KPH)',
                                  style: TextStyle(
                                      color: HexColor('F0C446'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  model.model!.current.windKph.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => const Opacity(
                      opacity: 0.7,
                      child: Image(
                        image: AssetImage(
                          'images/search.png',
                        ),
                        height: 200,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
