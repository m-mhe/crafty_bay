import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/model/payment_method.dart';
import 'package:crafty_bay/data/model/payment_method_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  bool _loading = false;
  int _total = 0;

  int get total => _total;

  bool get loading => _loading;
  List<PaymentMethod> _paymentMethods = [];

  List<PaymentMethod> get paymentMethods => _paymentMethods;

  Future<bool> fetchPaymentMethods() async {
    bool success;
    _loading = true;
    update();
    String authToken = await TokenController.getToken() ?? '';
    NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>()
            .getResponse(url: ServerURLSs.invoiceCall, token: authToken);
    if (networkServerResponse.isSuccess) {
      _loading = false;
      success = true;
      _paymentMethods =
          PaymentMethodModel.fromJson(networkServerResponse.responseBody)
                  .paymentMethodData?[0]
                  .paymentMethod ??
              [];
      _total = PaymentMethodModel.fromJson(networkServerResponse.responseBody)
              .paymentMethodData?[0]
              .payable ??
          0;
    } else {
      _loading = false;
      success = false;
    }
    update();
    return success;
  }
}
