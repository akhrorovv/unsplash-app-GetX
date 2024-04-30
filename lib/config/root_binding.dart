import 'package:get/get.dart';
import 'package:unsplash_app/controllers/collection_controller.dart';
import 'package:unsplash_app/controllers/collection_photos_controller.dart';
import 'package:unsplash_app/controllers/details_controller.dart';
import 'package:unsplash_app/controllers/home_controller.dart';
import 'package:unsplash_app/controllers/search_controller.dart';
import '../controllers/splash_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SearchesController(), fenix: true);
    Get.lazyPut(() => CollectionController(), fenix: true);
    Get.lazyPut(() => CollectionPhotosController(), fenix: true);
    Get.lazyPut(() => DetailsController(), fenix: true);
  }
}