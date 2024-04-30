import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_app/controllers/collection_controller.dart';
import '../views/item_collections.dart';

class CollectionPage extends StatefulWidget {
  static const String id = 'collection_page';

  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final collectionController = Get.find<CollectionController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectionController.apiCollections();

    collectionController.scrollController.addListener(() {
      if (collectionController.scrollController.position.maxScrollExtent <=
          collectionController.scrollController.offset) {
        print('Load next page');
        collectionController.currentPage++;
        collectionController.apiCollections();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Collections'),
          ),
          body: Stack(
            children: [
              Center(
                child: RefreshIndicator(
                  onRefresh: collectionController.handleRefresh,
                  child: ListView.builder(
                    controller: collectionController.scrollController,
                    itemCount: collectionController.collections.length,
                    itemBuilder: (context, index) {
                      return itemOfCollections(
                          collectionController.collections[index],
                          collectionController);
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
