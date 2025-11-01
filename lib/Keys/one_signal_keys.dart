import 'package:flutter_dotenv/flutter_dotenv.dart';

class OneSignalKeys{
   static final String? oneSignalKey=dotenv.env["ONE_SIGNAL_KEY"];
   static final String? oneSignalRestApiKey=dotenv.env["ONE_SIGNAL_REST_API_KEY"];
}