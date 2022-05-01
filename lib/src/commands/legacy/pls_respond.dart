import 'package:nyxx/nyxx.dart';

/// pls respond
Future<void> plsRespond(IMessageReceivedEvent event) async {
  if (event.message.content == 'pls respond') {
    event.message.channel.sendMessage(MessageBuilder.content('pls respond'));
  }
}
