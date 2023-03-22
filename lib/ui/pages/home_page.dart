import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/common/utils/notification_utils.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/list_restaurant/list_restaurant_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/favorite_page.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/search_page.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/setting_page.dart';
import 'package:flutter_dicoding_restaurant_app/ui/widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationsUtils notificationsUtils = NotificationsUtils();
  @override
  void initState() {
    notificationsUtils.configureSelectedNotificationSubject(context);
    super.initState();
  }

  void handleOnTap(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const FavoritePage();
      }));
    }

    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const SettingPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Restaurant'),
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
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Recommendation restaurant for you',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: BlocBuilder<ListRestaurantCubit, ListRestaurantState>(
                  builder: (context, state) {
                    if (state is ListRestaurantLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is ListRestaurantError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    if (state is ListRestaurantLoaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                            restaurant: state.restaurants[index],
                            handleCallback: () {
                              
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
            ],
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
        currentIndex: 0,
      ),
    );
  }
}
