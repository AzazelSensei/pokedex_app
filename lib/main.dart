import 'package:flutter/material.dart';
import 'package:pokedex_app/features/pokedex_list/view/pokedex_list_screen.dart';
import 'package:pokedex_app/network/endpoint.dart';
import 'package:pokedex_app/network/pokedex_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'features/pokedex_detail/cubit/pokedex_detail_cubit.dart';
import 'features/pokedex_list/cubit/pokedex_list_cubit.dart';

void main() {
  final pokedexRepo =
      PokedexRepository(Dio(BaseOptions(baseUrl: EndPoint.baseUrl)));
  runApp(MyApp(pokedexRepository: pokedexRepo));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.pokedexRepository}) : super(key: key);
  final PokedexRepository pokedexRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PokedexDetailCubit(pokedexRepository),
        ),
        BlocProvider(
          create: (context) => PokedexListCubit(pokedexRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PokedexListScreen(),
      ),
    );
  }
}
