import 'dart:convert';

extension Base64Conventer on String{
  String get toBase64{
    var bytes = utf8.encode(this);
    return base64Encode(bytes);
  }

  String get fromBase64{
    var bytes = base64Decode(this);
    return utf8.decode(bytes);
  }
}