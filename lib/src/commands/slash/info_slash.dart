import 'package:http/http.dart' as http;

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

Future<void> pingSlashHandler(ISlashCommandInteractionEvent event) async {
  final gatewayDelay = (event.client as INyxxWebsocket)
          .shardManager
          .shards
          .map((e) => e.gatewayLatency.inMilliseconds)
          .reduce((value, element) => value + element) /
      (event.client as INyxxWebsocket).shards;

  final apiStopwatch = Stopwatch()..start();
  await http.head(Uri(scheme: 'https', host: Constants.host, path: Constants.baseUri));
  final apiPing = apiStopwatch.elapsedMilliseconds;

  final stopwatch = Stopwatch()..start();

  final embed = EmbedBuilder()
  ..color = DiscordColor.blurple
  ..addField(name: 'Gateway Latency', content: '${gatewayDelay.abs().floor()}ms', inline: true)
  ..addField(name: 'REST API Latency', content: '$apiPing ms', inline: true)
  ..addField(name: 'Message roundup time', content: 'Pending...', inline: true);

  await event.respond(MessageBuilder.embed(embed));

  embed.replaceField(name: 'Message roundup time', content: '${stopwatch.elapsedMilliseconds} ms', inline: true);

  await event.editOriginalResponse(MessageBuilder.embed(embed));
}
