import 'dart:async';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/nyxx_commander.dart';
import 'package:judge_bot/src/internal/utils.dart' show envToken, envPrefix;

String get botToken => envToken!;

FutureOr<String?> prefixHandler(IMessage message) async =>
    mentionPrefixHandler(message) ?? envPrefix;
