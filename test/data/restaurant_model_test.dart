import 'dart:convert';

import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test parsing json restaurant', () {
    const jsonString = '''
    {
                "id": "s1knt6za9kkfw1e867",
                "name": "Kafe Kita",
                "description": "Quisque rutrum.",
                "pictureId": "25",
                "city": "Gorontalo",
                "rating": 4
            }
    ''';

    final parseData = Restaurant.fromJson(jsonDecode(jsonString));

    final restaurantObj = Restaurant(
        id: 's1knt6za9kkfw1e867',
        name: 'Kafe Kita',
        description: 'Quisque rutrum.',
        pictureId: '25',
        city: 'Gorontalo',
        rating: 4);

    expect(parseData, equals(restaurantObj));
  });
}
