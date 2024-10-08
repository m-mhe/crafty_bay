import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/cart_delete_controller.dart';
import 'package:crafty_bay/data/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/data/state_holders/category_list_controller.dart';
import 'package:crafty_bay/data/state_holders/create_cart_controller.dart';
import 'package:crafty_bay/data/state_holders/home_slider_controller.dart';
import 'package:crafty_bay/data/state_holders/login_controller.dart';
import 'package:crafty_bay/data/state_holders/product_list_by_remarks_controller.dart';
import 'package:crafty_bay/presentation/utils/navigation_controller.dart';
import 'package:crafty_bay/presentation/utils/second_counter.dart';
import 'package:get/get.dart';
import 'data/state_holders/create_profile_controller.dart';
import 'data/state_holders/pin_verify_controller.dart';
import 'data/state_holders/product_details_controller.dart';
import 'data/state_holders/product_list_by_category_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SecondCounter(), fenix: true);
    Get.put(NavigationController());
    Get.put(NetworkCaller());
    Get.put(HomeSliderController());
    Get.put(CategoryListController());
    Get.put(ProductListByRemarksController());
    Get.lazyPut(()=>ProductListByCategoriesController(), fenix: true);
    Get.lazyPut(()=>ProductDetailsController(), fenix: true);
    Get.lazyPut(()=>LoginController(), fenix: true);
    Get.lazyPut(()=>PinVerifyController(), fenix: true);
    Get.lazyPut(()=>CreateProfileController(), fenix: true);
    Get.lazyPut(()=>CreateCartController(), fenix: true);
    Get.lazyPut(()=>CartListController(), fenix: true);
    Get.lazyPut(()=>CartDeleteController(), fenix: true);
  }
}
