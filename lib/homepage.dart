import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restourant_finder/detail_screen.dart';
import 'package:restourant_finder/models/restaurant_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Restaurant>? _restaurantList;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _restaurantList = _getRestaurantList();
  }

  Future<Restaurant> _getRestaurantList() async {
    String data = await rootBundle.loadString("assets/data/restaurants.json");
    return restaurantFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            title: Row(
              children: [
                SizedBox(
                  height: 40,
                  child: Image.asset(
                    "assets/images/icon_restourant.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "Restaurant Finder",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      "assets/icons/menu_bar.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Image.asset("assets/images/image.png"),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Stop looking for a \n restaurant - find it.",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 15),
                                Icon(Icons.search_rounded),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _searchQuery = value.toLowerCase();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      hintText:
                                          "Search for Restaurants by Name, Cuisine, Location",
                                      hintStyle: GoogleFonts.inter(
                                          color: Color(0xFF787878),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<Restaurant>(
              future: _restaurantList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    snapshot.data!.restaurants.isEmpty) {
                  return Center(child: Text('No restaurants found'));
                }

                final restaurants =
                    snapshot.data!.restaurants.where((restaurant) {
                  return restaurant.name.toLowerCase().contains(_searchQuery) ||
                      restaurant.city.toLowerCase().contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: restaurants.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              restaurant: restaurant,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 24, left: 24, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 120,
                                child: Hero(
                                  tag: restaurant.id,
                                  child: Image.network(
                                    restaurant.pictureId,
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      restaurant.name,
                                      style: TextStyle(
                                        color: Color(0xFF252C32),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.08,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      restaurant.city,
                                      style: TextStyle(
                                        color: Color(0xFF696E73),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.06,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i < restaurant.rating.floor();
                                            i++)
                                          Container(
                                            child: SvgPicture.asset(
                                              "assets/icons/star.svg",
                                              color: Colors.orange,
                                            ),
                                          ),
                                        if (restaurant.rating % 1 > 0)
                                          Container(
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/star_half.svg",
                                                  color: Colors.orange
                                                      .withOpacity(.2),
                                                ),
                                                Positioned.fill(
                                                  left: 0,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SvgPicture.asset(
                                                      "assets/icons/star.svg",
                                                      color: Colors.orange
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Text(
                                          restaurant.rating.toString(),
                                          style: TextStyle(
                                            color: Color(0xFF373E44),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                            letterSpacing: 0.06,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
