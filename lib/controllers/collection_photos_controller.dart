import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_app/pages/details_page.dart';
import '../models/collections.dart';
import '../models/collections_photos.dart';
import '../models/details_photo.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CollectionPhotosController extends GetxController {
  DetailsPhoto? detailsPhoto;
  bool isLoading = true;
  late Collections collection;
  List<CollectionsPhotos> collectionPhotos = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  apiCollectionPhotos() async {
    try {
      var response = await Network.GET(
        Network.API_COLLECTIONS_PHOTOS.replaceFirst(':id', collection.id),
        Network.paramsCollectionsPhotos(currentPage),
      );

        collectionPhotos.addAll(Network.parseCollectionsPhotos(response!));
        isLoading = false;
      update();
      LogService.d(collectionPhotos.length.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  callDetailsPage(DetailsPhoto photo) {
    Get.to(DetailsPage(detailsPhoto: photo));
  }

  DetailsPhoto getPhoto(CollectionsPhotos photo) {
    return DetailsPhoto(
      id: photo.id,
      createdAt: photo.createdAt,
      width: photo.width,
      height: photo.height,
      description: photo.description,
      urls: photo.urls,
      user: photo.user,
    );
  }

  Future<void> handleRefresh() async {
    apiCollectionPhotos();
    collectionPhotos.clear();
  }
}