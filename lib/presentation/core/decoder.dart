import 'dart:convert';

class Decoder {
  static String text(String encoded) {
    String encodeNormalized = encoded;
    if (encodeNormalized.isNotEmpty) {
      int remainder = encodeNormalized.length % 4;

      for (int i = 0; i < remainder; i++) {
        encodeNormalized += "=";
      }
    }

    try {
      return utf8.decode(base64.decode(encodeNormalized));
    } catch (e) {
      // print(e);
      return "-";
    }
  }
}
