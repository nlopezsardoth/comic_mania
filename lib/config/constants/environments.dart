import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String marvelPublicKey =
      dotenv.env['MARVEL_PUBLIC_KEY'] ?? 'No public key';
  static String marvelPrivateKey =
      dotenv.env['MARVEL_PRIVATE_KEY'] ?? 'No private key';
}
