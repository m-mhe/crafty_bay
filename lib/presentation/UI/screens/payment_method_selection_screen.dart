import 'package:crafty_bay/data/state_holders/payment_methods_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/screens/payment_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/theme_colors.dart';
import '../widgets/icon_back_button.dart';

class PaymentMethodSelectionScreen extends StatefulWidget {
  const PaymentMethodSelectionScreen({super.key});

  @override
  State<PaymentMethodSelectionScreen> createState() =>
      _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState
    extends State<PaymentMethodSelectionScreen> {
  Future<void> _initializer() async {
    bool check =
        await Get.find<PaymentMethodsController>().fetchPaymentMethods();
    if (!check && mounted) {
      bottomPopUpMessage(context, 'Please Login!');
      Get.to(() => const EmailIdentificationScreen());
    }
  }

  @override
  void initState() {
    _initializer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconBackButton(whereToBack: () {
          Get.back();
        }),
        titleSpacing: 0,
        title: Text(
          'Payment methods',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: GetBuilder<PaymentMethodsController>(builder: (controller) {
        return Visibility(
          visible: !controller.loading,
          replacement: const LoadingIndicator(),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (BuildContext context, int i) {
                      return FittedBox(
                        child: SizedBox(
                            height: 1,
                            width: 1,
                            child: InkWell(
                              onTap: () {
                                Get.off(() => PaymentScreen(
                                    paymentURL: controller.paymentMethods[i]
                                            .redirectGatewayURL ??
                                        ''));
                              },
                              child: Image.network(
                                controller.paymentMethods[i].logo ??
                                    ServerURLSs.dummyImage,
                                fit: BoxFit.scaleDown,
                              ),
                            )),
                      );
                    },
                    itemCount: controller.paymentMethods.length,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 70,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    color: ThemeColor.accentColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(33),
                        topLeft: Radius.circular(33))),
                child: Center(
                  child: Text(
                    'Total: \$${controller.total} (including VAT)',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ThemeColor.lightAccentColor),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
