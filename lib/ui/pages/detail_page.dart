import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/common/constants.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/detail_restaurant/detail_restaurant_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/favorites_restaurant/favorite_detail/favorite_detail_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/favorites_restaurant/favorites_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_detail_model.dart';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_dicoding_restaurant_app/ui/widgets/menu_card.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context
        .read<DetailRestaurantCubit>()
        .getDetailRestaurant(widget.restaurant.id!);
    context.read<FavoriteDetailCubit>().getFavoriteById(widget.restaurant.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.restaurant.name!)),
        body: BlocBuilder<DetailRestaurantCubit, DetailRestaurantState>(
          builder: (context, state) {
            if (state is DetailRestaurantLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DetailRestaurantError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is DetailRestaurantLoaded) {
              return SafeArea(
                child: details(state.detail),
              );
            }

            return const Center(
              child: Text('data not found'),
            );
          },
        ));
  }

  Widget details(RestaurantDetail restaurant) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          child: CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: '${Constants.imagePath}${restaurant.pictureId!}',
            fit: BoxFit.cover,
          ),
        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name!,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<FavoriteDetailCubit>()
                                .clickFavorite(widget.restaurant);
                          },
                          icon: BlocListener<FavoriteDetailCubit,
                              FavoriteDetailState>(
                            listener: (context, state) {
                              if (state is FavoriteDetailSuccess) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.orange,
                                ));
                              }
                              if (state is FavoriteDetailError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            child: BlocBuilder<FavoriteDetailCubit,
                                FavoriteDetailState>(
                              builder: (context, state) {
                                if (state is FavoriteDetailFound) {
                                  return const Icon(
                                    Icons.favorite,
                                    color: Colors.orange,
                                  );
                                }
                                return const Icon(
                                  Icons.favorite_border,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('${restaurant.rating}'),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          restaurant.city!,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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

  Widget foodList(RestaurantDetail restaurant) {
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

  Widget drinkList(RestaurantDetail restaurant) {
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
