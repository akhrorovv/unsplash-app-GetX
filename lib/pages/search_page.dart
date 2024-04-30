import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unsplash_app/controllers/search_controller.dart';
import 'package:unsplash_app/models/search_photos.dart';
import 'package:unsplash_app/services/log_service.dart';
import '../models/details_photo.dart';
import '../models/photos.dart';
import '../services/http_service.dart';
import '../views/item_photos.dart';
import '../views/item_search_photos.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  static const String id = 'search_page';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.find<SearchesController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.apiPhotos();

    searchController.photosScrollController.addListener(() {
      if (searchController.photosScrollController.position.maxScrollExtent <=
          searchController.photosScrollController.offset) {
        searchController.currentPhotosPage++;
        searchController.apiPhotos();
      }
    });

    if (searchController.query != null) {
      searchController.apiSearchPhotos(searchController.query);
    }

    searchController.searchPhotosScrollController.addListener(() {
      if (searchController
              .searchPhotosScrollController.position.maxScrollExtent <=
          searchController.searchPhotosScrollController.offset) {
        searchController.currentSearchPhotosPage++;
        searchController.apiSearchPhotos(searchController.query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchesController>(
      builder: (_) {
        return Scaffold(
          // search bar
          appBar: AppBar(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: TextField(
                onSubmitted: (value) {
                  if (value == '') {
                    searchController.photos.clear();
                    searchController.apiPhotos();
                  } else {
                    searchController.searchPhotos();
                  }
                },
                // onChanged: (value) {
                //   if (value == '') {
                //     photos.clear();
                //     _apiPhotos();
                //   }
                // },
                textAlignVertical: TextAlignVertical.top,
                controller: searchController.queryController,
                decoration: InputDecoration(
                  hintText: "Search photos, collections, users",
                  hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                  prefixIcon: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Icon(Iconsax.search_normal),
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              (searchController.query == null)
                  ? RefreshIndicator(
                      onRefresh: searchController.handleRefresh,
                      child: Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: MasonryGridView.count(
                          controller: searchController.photosScrollController,
                          itemCount: searchController.photos.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            return itemOfPhotos(searchController.photos[index],
                                searchController);
                          },
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: searchController.handleRefresh,
                      child: searchController.searchingPhotos.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                      image: const DecorationImage(
                                        colorFilter:
                                            ColorFilter.srgbToLinearGamma(),
                                        image: AssetImage(
                                            'assets/images/no_data.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Text('Nothing to see here...')
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: MasonryGridView.count(
                                controller: searchController
                                    .searchPhotosScrollController,
                                itemCount:
                                    searchController.searchingPhotos.length,
                                crossAxisCount: 2,
                                itemBuilder: (context, index) {
                                  return itemOfSearchPhotos(
                                      searchController.searchingPhotos[index],
                                      searchController);
                                },
                              ),
                            ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
