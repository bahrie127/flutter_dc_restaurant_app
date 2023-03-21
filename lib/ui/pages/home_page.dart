import 'package:flutter/material.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_service.dart';
import 'package:flutter_dicoding_restaurant_app/ui/widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RestaurantModel> restaurantModel;
  @override
  void initState() {
    restaurantModel = RestaurantService().readRestaurantJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: FutureBuilder(
                  future: restaurantModel,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return RestaurantCard(
                                restaurant: snapshot.data!.restaurants![index]);
                          },
                          itemCount: snapshot.data!.restaurants!.length,
                        );
                      } else {
                        return const Center(
                          child: Text('no data'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
