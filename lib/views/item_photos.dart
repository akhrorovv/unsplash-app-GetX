import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_app/controllers/search_controller.dart';

import '../models/photos.dart';

Widget itemOfPhotos(Photo photo, SearchesController searchController) {
  return GestureDetector(
    onTap: () {
      searchController.callDetailsPage(searchController.getPhoto(photo));
    },
    child: Hero(
      tag: photo.id,
      child: AspectRatio(
        aspectRatio: photo.width.toDouble() / photo.height.toDouble(),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: CachedNetworkImage(
            memCacheHeight: 200,
            memCacheWidth: 150,
            fit: BoxFit.cover,
            imageUrl: photo.urls.regular,
            placeholder: (context, urls) => Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            errorWidget: (context, urls, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
