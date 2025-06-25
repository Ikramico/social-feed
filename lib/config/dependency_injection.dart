import 'package:feed/controller/navigation_controller.dart';
import 'package:feed/controller/review_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    Get.put(ReviewController());
    Get.put(NavigationController());
  }
}
