library judge_bot;

/// Legacy commands
export 'src/commands/legacy/info_legacy.dart';
export 'src/commands/legacy/math_legacy.dart';
export 'src/commands/legacy/pasta_legacy.dart';
export 'src/commands/legacy/pls_respond.dart';
export 'src/commands/legacy/reply_legacy.dart';
export 'src/commands/legacy/league_set_legacy.dart';

/// Slash commands
export 'src/commands/slash/info_slash.dart';
export 'src/commands/slash/price_check_slash.dart';

/// Api data
export 'src/api/ninja_items.dart';

/// Config stuff
export 'src/modules/settings/settings.dart' show botToken, prefixHandler;
export 'src/internal/utils.dart' show getSyncCommandsOrOverride, clientId;