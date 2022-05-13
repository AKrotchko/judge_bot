import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/nyxx_commander.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

import 'package:judge_bot/judge_bot.dart' as jb;

late INyxxWebsocket botInstance;

/// List of guilds (By ID) that have access to stupid commands
List<int> guildList = [
  643138753891663882, // global-discussion3
  592802690774597652, // JDA Hack Week (My bot testing server)
  240635484517302285 // The hangout
];

int permissionsInt = 405941644353;
String joinUrl =
    'https://discordapp.com/api/oauth2/authorize?client_id=${jb.clientId}&scope=bot&permissions=$permissionsInt';

void main(List<String> arguments) async {
  print('Starting Judge Bot...');
  print('Add Judge Bot to your server: $joinUrl');

  /// Fetches data from poe.ninja on every item (Find a way to cache this)
  jb.loadNinjaData();

  botInstance = NyxxFactory.createNyxxWebsocket(
      jb.botToken, GatewayIntents.allUnprivileged,
      options: ClientOptions(guildSubscriptions: true, messageCacheSize: 10))

    /// Whenever the bot sees a message (Or DM!)
    ..eventsWs.onMessageReceived.listen((event) {
      final id = event.message.guild != null
          ? event.message.guild!.id.toString()
          : 'dm';

      /// Stupid idiot stuff - Only certain guilds can use these commands
      if (!event.message.author.bot && guildList.contains(int.tryParse(id))) {
        jb.pasta(event); // Copypasta command, roughly 1/10,000 chance
        jb.plsRespond(event); // pls respond
      }
    })

    /// When the bot is mentioned
    ..eventsWs.onSelfMention.listen((event) {
      final id = event.message.guild != null
          ? event.message.guild!.id.toString()
          : 'dm';

      /// Stupid idiot stuff - Only certain guilds can use these commands
      if (!event.message.author.bot && guildList.contains(int.tryParse(id))) {
        jb.replyCommand(event); // This should be rewritten, it's crap
      }
    });

  await botInstance.connect();
  print('Connected to Discord');

  ICommander.create(botInstance, jb.prefixHandler)

    /// Old style commands
    ..registerCommand('calc', jb.mathCommand)
    ..registerCommand('info', jb.infoCommand)
    ..registerCommand('league', jb.leagueSetCommand);

  IInteractions.create(WebsocketInteractionBackend(botInstance))
    ..registerSlashCommand(SlashCommandBuilder('ping', 'Shows bots latency', [])
      ..registerHandler(jb.pingSlashHandler))
    ..registerSlashCommand(
        SlashCommandBuilder('pc', 'Price check an item on poe.ninja', [
      CommandOptionBuilder(
          CommandOptionType.string, 'name', 'Name of the item to check',
          required: true),
    ])
          ..registerHandler(jb.priceCheckSlashHandler))
    ..syncOnReady(
        syncRule: ManualCommandSync(sync: jb.getSyncCommandsOrOverride(true)));
  // ..events.onSlashCommand.listen((event) => jb.slashCommandsTotalUsageMetric.labels([event.interaction.name]).inc());

  print('Judge Bot is ready!');
  // await jb.initReminderModule(botInstance);
  // jb.registerPeriodicCollectors(botInstance);

  // jb.setupDocsUpdateJob();
}
