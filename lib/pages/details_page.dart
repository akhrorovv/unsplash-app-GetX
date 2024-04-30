import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unsplash_app/controllers/details_controller.dart';
import 'package:unsplash_app/services/log_service.dart';
import '../models/details_photo.dart';
import 'package:iconsax/iconsax.dart';

class DetailsPage extends StatefulWidget {
  static const String id = 'details_page';
  DetailsPhoto? detailsPhoto;

  DetailsPage({super.key, this.detailsPhoto});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final detailsController = Get.find<DetailsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsController.detailsPhoto = widget.detailsPhoto!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: GetBuilder<DetailsController>(
        builder: (_){
          return Stack(
            children: [
              Hero(
                tag: detailsController.detailsPhoto.id,
                child: InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 3,
                  constrained: true,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: detailsController.detailsPhoto.urls.regular,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //# back button
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(25)),
                            child: const Icon(
                              Iconsax.arrow_left_3,
                              size: 30,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 8.0)
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),

                        //#bottom sheet
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              scrollControlDisabledMaxHeightRatio: double.infinity,
                              backgroundColor: Colors.black.withOpacity(0.8),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(30),
                                  height: MediaQuery.of(context).size.height / 1.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: detailsController
                                                  .detailsPhoto
                                                  .user
                                                  .profileImage
                                                  .medium,
                                              placeholder: (context, urls) =>
                                                  Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                        BorderRadius.circular(25),
                                                      ),
                                                    ),
                                                  ),
                                              errorWidget: (context, urls, error) =>
                                              const Icon(Icons.error),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(25),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            detailsController
                                                .detailsPhoto.user.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: const Text(
                                          'Description',
                                          style: TextStyle(color: Colors.white30),
                                        ),
                                      ),
                                      Text(
                                        detailsController.getDescription(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: const Text(
                                          'Published',
                                          style: TextStyle(color: Colors.white30),
                                        ),
                                      ),
                                      Text(
                                        detailsController.detailsPhoto.createdAt
                                            .toIso8601String()
                                            .substring(0, 10),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: const Text(
                                          'Dimensions',
                                          style: TextStyle(color: Colors.white30),
                                        ),
                                      ),
                                      Text(
                                        '${detailsController.detailsPhoto.width} / ${detailsController.detailsPhoto.height}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(25)),
                            child: const Icon(
                              Iconsax.info_circle,
                              size: 30,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 8.0)
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //# share button
                        IconButton(
                          onPressed: () {
                            detailsController.share();
                          },
                          icon: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Iconsax.export_3,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 8.0)
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //# save image button
                            IconButton(
                              icon: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Iconsax.gallery_import,
                                  size: 25,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 8.0)
                                  ],
                                ),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                detailsController.saveNetworkImage();
                                LogService.i('hi');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
