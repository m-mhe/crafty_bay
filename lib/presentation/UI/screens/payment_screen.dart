import 'package:crafty_bay/presentation/UI/widgets/payment_failed.dart';
import 'package:crafty_bay/presentation/UI/widgets/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/icon_back_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.paymentURL});

  final String paymentURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconBackButton(whereToBack: () {
          Get.back();
        }),
        titleSpacing: 0,
        title: Text(
          'Payment',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {
                  if (url.endsWith('success')) {
                    Get.off(() => const PaymentSuccess());
                  } else if (url.endsWith('Failed')) {
                    Get.off(() => const PaymentFailed());
                  }
                },
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(paymentURL))),
    );
  }
}
