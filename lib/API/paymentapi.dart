import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<PaymentModel?> paymentpackage({required String packid}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  var url = Uri.parse("$mainurl/makePayment.php");
  var response = await http.post(url,
      body: {'API_KEY': APIkey, 'user_id': userid, "pack_id": packid});

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    log(data.toString());
    // toast(data['message']);
    return PaymentModel.fromJson(jsonDecode(response.body));
  } else {
    print('Failed to send data. Error code: ${response.statusCode}');
    return PaymentModel();
  }
}

class PaymentModel {
  bool? acceptPartial;
  int? amount;
  int? amountPaid;
  String? callbackMethod;
  String? callbackUrl;
  int? cancelledAt;
  int? createdAt;
  String? currency;
  Customer? customer;
  String? description;
  int? expireBy;
  int? expiredAt;
  int? firstMinPartialAmount;
  String? id;
  Notes? notes;
  Notify? notify;
  Null payments;
  String? referenceId;
  bool? reminderEnable;
  List<Null>? reminders;
  String? shortUrl;
  String? status;
  int? updatedAt;
  bool? upiLink;
  String? userId;
  bool? whatsappLink;

  PaymentModel(
      {this.acceptPartial,
      this.amount,
      this.amountPaid,
      this.callbackMethod,
      this.callbackUrl,
      this.cancelledAt,
      this.createdAt,
      this.currency,
      this.customer,
      this.description,
      this.expireBy,
      this.expiredAt,
      this.firstMinPartialAmount,
      this.id,
      this.notes,
      this.notify,
      this.payments,
      this.referenceId,
      this.reminderEnable,
      this.reminders,
      this.shortUrl,
      this.status,
      this.updatedAt,
      this.upiLink,
      this.userId,
      this.whatsappLink});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    acceptPartial = json['accept_partial'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    callbackMethod = json['callback_method'];
    callbackUrl = json['callback_url'];
    cancelledAt = json['cancelled_at'];
    createdAt = json['created_at'];
    currency = json['currency'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    description = json['description'];
    expireBy = json['expire_by'];
    expiredAt = json['expired_at'];
    firstMinPartialAmount = json['first_min_partial_amount'];
    id = json['id'];
    notes = json['notes'] != null ? new Notes.fromJson(json['notes']) : null;
    notify =
        json['notify'] != null ? new Notify.fromJson(json['notify']) : null;
    payments = json['payments'];
    referenceId = json['reference_id'];
    reminderEnable = json['reminder_enable'];

    shortUrl = json['short_url'];
    status = json['status'];
    updatedAt = json['updated_at'];
    upiLink = json['upi_link'];
    userId = json['user_id'];
    whatsappLink = json['whatsapp_link'];
  }
}

class Customer {
  String? contact;
  String? email;
  String? name;

  Customer({this.contact, this.email, this.name});

  Customer.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    email = json['email'];
    name = json['name'];
  }
}

class Notes {
  String? packageName;

  Notes({this.packageName});

  Notes.fromJson(Map<String, dynamic> json) {
    packageName = json['Package Name'];
  }
}

class Notify {
  bool? email;
  bool? sms;
  bool? whatsapp;

  Notify({this.email, this.sms, this.whatsapp});

  Notify.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    sms = json['sms'];
    whatsapp = json['whatsapp'];
  }
}
