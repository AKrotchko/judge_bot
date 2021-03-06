import 'package:nyxx_commander/nyxx_commander.dart';
import 'package:judge_bot/src/commands/info_common.dart' show infoGenericCommand;

Future<void> infoCommand(ICommandContext ctx, String content) async {
  await ctx.reply(await infoGenericCommand(ctx.client));
}