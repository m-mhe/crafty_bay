import 'package:crafty_bay/data/model/payment_method_data.dart';

class PaymentMethodModel {
  String? msg;
  List<PaymentMethodData>? paymentMethodData;

  PaymentMethodModel({this.msg, this.paymentMethodData});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      paymentMethodData = <PaymentMethodData>[];
      json['data'].forEach((v) {
        paymentMethodData!.add(new PaymentMethodData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.paymentMethodData != null) {
      data['data'] = this.paymentMethodData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
