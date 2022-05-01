import 'package:nyxx/nyxx.dart';

/// When pinged, the bot will yell back at others. It's very childish. In the
/// future, I'd like to learn how to do this properly with replies. Until then,
/// you get this piece of garbage.
///
/// (This no work right now)
Future<void> replyCommand(IMessageReceivedEvent event) async {
  String dickwadId = event.message.author.id.toString();

  event.message.channel
      .sendMessage(MessageBuilder.content('<@!$dickwadId> no u'));
}
