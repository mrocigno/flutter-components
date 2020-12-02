/*
* Created to flutter-components at 05/12/2020
*/
import "dart:developer" as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_useful_things/components/image/ImagePlaceholder.dart';
import 'package:flutter_useful_things/components/textviews/TextStyles.dart';

class UserIcon extends StatelessWidget {

  final String userName;
  final String imagePath;
  final Function onPressed;

  UserIcon({
    @required this.userName,
    this.imagePath,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    var initialIcons;
    var nameSplit = userName.split(" ");
    if(nameSplit.length > 1){
      initialIcons = nameSplit[0].substring(0, 1).toUpperCase() + nameSplit[1].substring(0, 1).toUpperCase();
    } else {
      initialIcons = userName.substring(0, 1).toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        clipBehavior: Clip.hardEdge,
        child: (imagePath != null? (
          IconButton(
            padding: const EdgeInsets.all(0),
            icon: CachedNetworkImage(
              imageUrl: imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) => ImagePlaceholder(),
            ),
            onPressed: onPressed
          )
        ) : (
          InkWell(
            child: Container(
              height: 50, width: 50,
              alignment: Alignment.center,
              child: Text(initialIcons, style: TextStyles.title2Black),
            ),
            onTap: onPressed,
          )
        )),
      )
    );
  }
}