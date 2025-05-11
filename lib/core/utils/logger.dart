import 'package:logger/logger.dart';

void logMessage(String message) {
  Logger().d('[ZephyrPay] $message', time: DateTime.now());
}
