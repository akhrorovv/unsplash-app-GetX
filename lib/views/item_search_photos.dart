import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_app/controllers/search_controller.dart';

import '../models/search_photos.dart';

Widget itemOfSearchPhotos(SearchPhoto searchPhotos, SearchesController searchController) {
  return Hero(
    tag: searchPhotos.id,
    child: AspectRatio(
      aspectRatio:
      searchPhotos.width.toDouble() / searchPhotos.height.toDouble(),
      child: GestureDetector(
        onTap: () {
          searchController.callDetailsPage(searchController.getSearchPhoto(searchPhotos));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: searchPhotos.urls.regular,
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
