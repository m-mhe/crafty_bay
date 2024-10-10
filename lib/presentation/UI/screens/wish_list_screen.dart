import 'package:crafty_bay/presentation/UI/widgets/icon_back_button.dart';
import 'package:crafty_bay/presentation/utils/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/product_card.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, _) {
        Get.find<NavigationController>().goToHomeScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconBackButton(whereToBack: () {
            Get.find<NavigationController>().goToHomeScreen();
          }),
          titleSpacing: 0,
          title: Text(
            'Wish List',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: LayoutBuilder(builder: (context, screen) {
            if (screen.maxWidth < 300) {
              return GridView.builder(
                itemCount: 200,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5),
                itemBuilder: (BuildContext context, int index) {
                  return  FittedBox(child: ProductCard(title: '', price: '', star: '', image: '', id: 0,));
                },
              );
            } else {
              return GridView.builder(
                itemCount: 200,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5),
                itemBuilder: (BuildContext context, int index) {
                  return  FittedBox(child: ProductCard(title: '', price: '', star: '', image: '', id: 0,));
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
