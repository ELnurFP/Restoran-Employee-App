import 'dart:convert';
import 'dart:io';

import 'package:template/configs/base64_conventer.dart';

abstract class BaseReqModel {
  Map<String, dynamic> toJson();

  Future<Map<String, String>> toBase64() async {
    var data = toJson();
    Map<String, String> base64DataMap = {};
    data.forEach((key, value) async {
      if (value != null) {
        if (value! is Map) {
          base64DataMap[key] = json.encode(value).toBase64;
        } else if (value! is File) {
          var bitMap = await value.readAsBytes();
          var base64Str = base64.encode(bitMap);
          base64DataMap[key] = base64Str.toString();
        } else {
          //var strData =
          base64DataMap[key] = value.toString().toBase64;
          // var bitMap = utf8.encode(strData);
          // var base64Str = base64Encode(bitMap);
          // base64DataMap[key] = base64Str;
        }
      }
    });

    return base64DataMap;
  }
}
