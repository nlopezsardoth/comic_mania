import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'package:comic_mania/config/constants/environments.dart';

class EncryptionService {
  Future<Map<String, dynamic>> marvelEncryption() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String privateKey = Environment.marvelPrivateKey;
    String publicKey = Environment.marvelPublicKey;

    var content =
        const Utf8Encoder().convert("$timestamp$privateKey$publicKey");
    var md5 = crypto.md5;
    var digest = md5.convert(content);

    Map<String, dynamic> parameters = {
      "ts": "$timestamp",
      "hash": hex.encode(digest.bytes),
    };

    return parameters;
  }
}
