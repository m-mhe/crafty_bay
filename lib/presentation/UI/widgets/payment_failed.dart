import 'package:crafty_bay/presentation/UI/screens/bottom_navigation_widgets.dart';
import 'package:crafty_bay/presentation/utils/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/theme_colors.dart';
import 'icon_back_button.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconBackButton(whereToBack: () {
          Get.back();
        }),
        titleSpacing: 0,
        title: Text(
          'Payment Failed',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: const Center(
        child: Icon(
          Icons.cancel,
          color: Colors.red,
          size: 100,
        ),
      ),
    );
  }
}
