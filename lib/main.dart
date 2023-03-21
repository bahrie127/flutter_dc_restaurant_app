import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/detail_restaurant/detail_restaurant_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/favorites_restaurant/favorite_detail/favorite_detail_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/favorites_restaurant/favorites_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/list_restaurant/list_restaurant_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/search_restaurant/search_restaurant_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/data/db/favorites_db.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_service.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/home_page.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ListRestaurantCubit(RestaurantService())..getListRestaurant(),
        ),
        BlocProvider(
          create: (context) => SearchRestaurantCubit(RestaurantService()),
        ),
        BlocProvider(
          create: (context) => DetailRestaurantCubit(RestaurantService()),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(FavoritesDb()),
        ),
        BlocProvider(
          create: (context) => FavoriteDetailCubit(FavoritesDb()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage(),
      ),
    );
  }
}
