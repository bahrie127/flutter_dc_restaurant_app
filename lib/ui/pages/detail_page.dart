import 'package:flutter/material.dart';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_dicoding_restaurant_app/ui/widgets/menu_card.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(restaurant.name!)),
        body: SafeArea(
          child: Column(
            children: [
              Hero(
                tag: restaurant.pictureId!,
                child: AnimatedContainer(
                  width: double.infinity,
                  height: 200,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        restaurant.pictureId!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(child: details(restaurant)),
            ],
          ),
        ));
  }

  Widget details(Restaurant restaurant) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name!,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(restaurant.city!,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            restaurant.description!,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        foodList(restaurant),
        const SizedBox(
          height: 30,
        ),
        drinkList(restaurant),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget foodList(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            'Food List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurant.menus!.foods!.length,
          itemBuilder: (context, index) {
            return MenuCard(text: restaurant.menus!.foods![index].name!);
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget drinkList(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text('Drink List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurant.menus!.drinks!.length,
          itemBuilder: (context, index) {
            return MenuCard(text: restaurant.menus!.drinks![index].name!);
          },
        ),
      ],
    );
  }
}
