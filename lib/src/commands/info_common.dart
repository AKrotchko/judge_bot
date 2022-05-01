import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:judge_bot/src/internal/utils.dart' show dartVersion, getMemoryUsageString;
import 'package:time_ago_provider/time_ago_provider.dart' show formatFull;

Future<ComponentMessageBuilder> infoGenericCommand(INyxxWebsocket client,
    [int shardId = 0]) async {
  final embed = EmbedBuilder()
    ..addAuthor((author) {
      author.name = client.self.tag;
      author.iconUrl = client.self.avatarURL();
      author.url = 'https://github.com/AKrotchko/';
    })
    ..addFooter((footer) {
      footer.text =
          'Nyxx v${client.version} | Shard ${shardId + 1} of ${client.shards} | Dart SDK $dartVersion';
    })
    ..color = DiscordColor.aquamarine
    ..addField(
        name: 'Cached guilds', content: client.guilds.length, inline: true)
    ..addField(name: 'Cached users', content: client.users.length, inline: true)
    ..addField(
        name: 'Cached channels', content: client.channels.length, inline: true)
    ..addField(
        name: 'Cached voice channels',
        content: client.guilds.values
            .map((g) => g.voiceStates.length)
            .reduce((f, s) => f + s),
        inline: true)
    ..addField(name: 'Shard count', content: client.shards, inline: true)
    ..addField(
        name: 'Cached messages',
        content: client.channels.values
            .whereType<ITextChannel>()
            .map((e) => e.messageCache.length)
            .fold(0, (first, second) => (first as int) + second),
        inline: true)
    ..addField(
        name: 'Memory usage (current/RSS)',
        content: getMemoryUsageString(),
        inline: true)
    ..addField(name: 'Uptime', content: formatFull(client.startTime));

  return ComponentMessageBuilder()..embeds = [embed];
}
