import 'dart:io';

String? get clientId => Platform.environment['CLIENT_ID'];
String? get clientSecret => Platform.environment['CLIENT_SECRET'];
String? get envToken => Platform.environment['BOT_TOKEN'];
String? get envPrefix => Platform.environment['BOT_PREFIX'];
bool get syncCommands => isBool(Platform.environment['SYNC_COMMANDS']);

bool getSyncCommandsOrOverride([bool? overrideSync]) => overrideSync ?? syncCommands;

bool isBool(String? value) {
  return value != null && (value == 'true' || value == '1');
}

String get dartVersion {
  final platformVersion = Platform.version;
  return platformVersion.split('(').first;
}

String getMemoryUsageString() {
  final current = (ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2);
  final rss = (ProcessInfo.maxRss / 1024 / 1024).toStringAsFixed(2);
  return '$current/${rss}MB';
}