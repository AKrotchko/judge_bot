library judge_bot;

/// Legacy commands
export 'src/commands/legacy/info_legacy.dart';
export 'src/commands/legacy/math_legacy.dart';
export 'src/commands/legacy/pasta_legacy.dart';
export 'src/commands/legacy/pls_respond.dart';
export 'src/commands/legacy/reply_legacy.dart';

/// Slash commands
export 'src/commands/slash/info_slash.dart';

/// Config stuff
export 'src/modules/settings/settings.dart' show botToken, prefixHandler;
export 'src/internal/utils.dart' show getSyncCommandsOrOverride, clientId;