import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/cubit/search_restaurant/search_restaurant_cubit.dart';
import 'package:flutter_dicoding_restaurant_app/ui/widgets/restaurant_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController? _searchController;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Restaurant',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (_searchController!.text.isNotEmpty) {
                    context
                        .read<SearchRestaurantCubit>()
                        .getSearchRestaurant(_searchController!.text);
                  }
                },
              ),
            ),
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                context
                    .read<SearchRestaurantCubit>()
                    .getSearchRestaurant(value);
              }
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child:
                    BlocBuilder<SearchRestaurantCubit, SearchRestaurantState>(
                  builder: (context, state) {
                    if (state is SearchRestaurantLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is SearchRestaurantError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    if (state is SearchRestaurantNotFound) {
                      return const Center(
                        child: Text('not found'),
                      );
                    }

                    if (state is SearchRestaurantLoaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                            restaurant: state.restaurants[index],
                            handleCallback: () {},
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
    );
  }
}
