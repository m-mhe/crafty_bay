import 'package:crafty_bay/data/model/payment_method.dart';

class PaymentMethodData {
  List<PaymentMethod>? paymentMethod;
  int? payable;
  int? vat;
  int? total;

  PaymentMethodData({this.paymentMethod, this.payable, this.vat, this.total});

  PaymentMethodData.fromJson(Map<String, dynamic> json) {
    if (json['paymentMethod'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['paymentMethod'].forEach((v) {
        paymentMethod!.add(PaymentMethod.fromJson(v));
      });
    }
    payable = json['payable'];
    vat = json['vat'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod!.map((v) => v.toJson()).toList();
    }
    data['payable'] = payable;
    data['vat'] = vat;
    data['total'] = total;
    return data;
  }
}
