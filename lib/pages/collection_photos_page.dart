import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:unsplash_app/controllers/collection_photos_controller.dart';
import '../models/collections.dart';
import '../models/collections_photos.dart';
import '../services/log_service.dart';
import '../views/item_collection_photos.dart';

class CollectionPhotosPage extends StatefulWidget {
  static const String id = 'collection_photos_page';
  final Collections? collection;

  const CollectionPhotosPage({super.key, this.collection});

  @override
  State<CollectionPhotosPage> createState() => _CollectionPhotosPageState();
}

class _CollectionPhotosPageState extends State<CollectionPhotosPage> {
  final collectionPhotosController = Get.find<CollectionPhotosController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectionPhotosController.collection = widget.collection!;
    collectionPhotosController.apiCollectionPhotos();

    collectionPhotosController.scrollController.addListener(() {
      if (collectionPhotosController
              .scrollController.position.maxScrollExtent <=
          collectionPhotosController.scrollController.offset) {
        print('Load next page');
        collectionPhotosController.currentPage++;
        collectionPhotosController.apiCollectionPhotos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.collection!.title),
      ),
      body: GetBuilder<CollectionPhotosController>(
        builder: (_){
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: collectionPhotosController.handleRefresh,
                child: Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: MasonryGridView.count(
                    controller: collectionPhotosController.scrollController,
                    itemCount: collectionPhotosController.collectionPhotos.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return itemOfCollectionPhotos(
                          collectionPhotosController.collectionPhotos[index], collectionPhotosController);
                    },
                  ),
                ),
              ),
              collectionPhotosController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : collectionPhotosController.collectionPhotos.isEmpty
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
                          colorFilter: ColorFilter.srgbToLinearGamma(),
                          image: AssetImage('assets/images/no_data.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Nothing to see here...')
                  ],
                ),
              )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

}
