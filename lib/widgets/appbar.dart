import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          SizedBox(
            height: 40,
            child: Image.asset(
              "assets/images/icon_restourant.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "Restaurant Finder",
            style: Theme.of(context).textTheme.titleLarge,
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
          )
        ],
      ),
    );
  }