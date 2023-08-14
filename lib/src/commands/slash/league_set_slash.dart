import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:judge_bot/src/api/ninja/objects.dart';
import 'package:judge_bot/src/api/ninja/variables.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

Future<void> leagueSlashHandler(ISlashCommandInteractionEvent event) async {
  if (event.interaction.userAuthor?.id.id == 97837550491664384) {
    String leagueName = event.getArg('name').value.toString();

    await event.respond(MessageBuilder.content('Attempting to set league to $leagueName...'));

    var url = Uri.parse(
        'https://poe.ninja/api/data/economysearch?league=$leagueName&languages=en');

    var response = await http.get(url);
    print('Processing data from poe.ninja...');
    var data = json.decode(response.body);

    ninjaItems = [];

    data['items'].keys.forEach((String itemType) {
      data['items'][itemType].forEach((item) {
        String type = itemType;
        String name = item['name'] ?? '';
        String icon = item['icon'] ?? '';

        ninjaItems.add(NinjaItem(type: type, name: name, icon: icon));
      });
    });

    print('Data from poe.ninja processed!');
    league = leagueName;

    await event
        .respond(MessageBuilder.content('League updated to $leagueName'));
  } else {
    await event.respond(MessageBuilder.content('I have no idea who you are'));
  }
}
