import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/favorites_restaurant/favorites_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/search_page.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/setting_page.dart';
import 'package:flutter_dicoding_restaurant_app/ui/widgets/restaurant_card.dart';

import 'home_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<FavoritesCubit>().getFavorites();
    super.initState();
  }

  void handleOnTap(int index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }

    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const SettingPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Favorite Restaurant'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }));
              },
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is FavoritesError) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is FavoritesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                      restaurant: state.restaurants[index],
                      handleCallback: () {
                        context.read<FavoritesCubit>().getFavorites();
                      },
                    );
                  },
                  itemCount: state.restaurants.length,
                );
              }

              return const Center(
                child: Text('no data'),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        onTap: handleOnTap,
        currentIndex: 1,
      ),
    );
  }
}
