// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:template/models/cancel_order_owner_req_model.dart';
// import 'package:template/models/create_order_req_model.dart';
// import 'package:template/models/general_req_model.dart';
// import 'package:template/models/general_with_order_req_model.dart';
// import 'package:template/models/get_all_orders_res_model.dart';
// import 'package:template/models/get_order_res_model.dart';
// import 'package:template/models/get_reasons_res_model.dart';
// import 'package:template/models/get_saved_orders_res_model.dart';
// import 'package:template/models/increase_payment_req_model.dart';
// import 'package:template/models/notifications_res_model.dart';
// import 'package:template/models/owner_order_accept_decline_req_model.dart';
// import 'package:template/models/payment_res_model.dart';
// import 'package:template/models/status_model.dart';

// import '../../dependency_injection.dart';
// import '../../models/buy_premium_req_model.dart';
// import '../../models/get_balance_history_res_model.dart';
// import 'api_service.dart';

// class PaymentService extends ApiService<PaymentResModel,OwnerOrderAcceptDeclineReqModel>{
//     @override
//   FutureOr<StatusModel?> getApiData(OwnerOrderAcceptDeclineReqModel body) async {
//     var queryParameters =await body.toBase64();
//     var response = await locator.get<Dio>().get('',queryParameters: queryParameters);
//     if(response.statusCode == 200){
//       return StatusModel().fromJson(response.data) as StatusModel;
//     }
//   }
// }