import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/details_photo.dart';
import '../models/photos.dart';
import '../models/search_photos.dart';
import '../pages/details_page.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class SearchesController extends GetxController {
  bool isLoading = true;
  DetailsPhoto? detailsPhoto;
  String? query;
  List<Photo> photos = [];
  List<SearchPhoto> searchingPhotos = [];
  ScrollController photosScrollController = ScrollController();
  ScrollController searchPhotosScrollController = ScrollController();
  int currentPhotosPage = 1;
  int currentSearchPhotosPage = 1;

  final TextEditingController queryController = TextEditingController();

  apiPhotos() async {
    try {
      var response = await Network.GET(
          Network.API_PHOTOS, Network.paramsPhotos(currentPhotosPage));

      photos.addAll(Network.parsePhotosList(response!));
      isLoading = false;
      update();

      LogService.d(photos.length.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  apiSearchPhotos(String? query) async {
    try {
      var response = await Network.GET(Network.API_SEARCH_PHOTOS,
          Network.paramsSearchPhotos(query!, currentSearchPhotosPage));

      searchingPhotos
          .addAll((Network.parseSearchPhotos(response!)).searchPhotos);
      isLoading = false;
      update();

      LogService.d(searchingPhotos.length.toString());
      query = null;
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  void searchPhotos() {
    searchingPhotos.clear();
    query = queryController.text;
    apiSearchPhotos(query!);
  }

  callDetailsPage(DetailsPhoto photo) {
    Get.to(DetailsPage(detailsPhoto: photo));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return DetailsPage(detailsPhoto: photo);
    //     },
    //   ),
    // );
  }

  DetailsPhoto getPhoto(Photo photo) {
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

  DetailsPhoto getSearchPhoto(SearchPhoto searchPhoto) {
    return DetailsPhoto(
      id: searchPhoto.id,
      createdAt: searchPhoto.createdAt,
      width: searchPhoto.width,
      height: searchPhoto.height,
      description: searchPhoto.description,
      urls: searchPhoto.urls,
      user: searchPhoto.user,
    );
  }

  Future<void> handleRefresh() async {
    apiPhotos();
    photos.clear();
  }
}
