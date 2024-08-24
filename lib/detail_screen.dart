import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restourant_finder/models/restaurant_model.dart';

class DetailScreen extends StatelessWidget {
  final RestaurantElement restaurant;

  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: restaurant.id,
                  child: Image.network(restaurant.pictureId)),
              SizedBox(height: 16),
              Text(
                restaurant.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                restaurant.city,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  for (int i = 0; i < restaurant.rating.floor(); i++)
                    Icon(Icons.star, color: Colors.orange),
                  if (restaurant.rating % 1 > 0)
                    Icon(Icons.star_half, color: Colors.orange),
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                restaurant.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Menus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Foods',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: restaurant.menus.foods
                      .map(
                        (food) => Card(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                SvgPicture.asset(
                                    'assets/icons/hamburger-soda.svg',
                                    width: 50,
                                    height: 50,
                                    color: Colors.black),
                                Spacer(),
                                Expanded(
                                    child: Text(
                                  food.name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Drinks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: restaurant.menus.drinks
                      .map(
                        (drink) => Card(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                SvgPicture.asset(
                                    'assets/icons/martini-glass-citrus.svg',
                                    width: 50,
                                    height: 50,
                                    color: Colors.black),
                                Spacer(),
                                Expanded(
                                    child: Text(
                                  drink.name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
