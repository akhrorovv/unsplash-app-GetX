import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import '../models/details_photo.dart';

class DetailsController extends GetxController {
  late DetailsPhoto detailsPhoto;

  String getDescription() {
    if (detailsPhoto.description == null) {
      return '-';
    }
    return detailsPhoto.description!;
  }
  share() async {
    await Share.share(detailsPhoto.urls.full);
  }

  static void showToast() {
    Fluttertoast.showToast(
      msg: "Image saved",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  saveNetworkImage() async {
    var response = await Dio().get(detailsPhoto.urls.full,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 80,
      name: "unsplash_app_${detailsPhoto.id}",
    );
    print(result);
    showToast();
  }
}
