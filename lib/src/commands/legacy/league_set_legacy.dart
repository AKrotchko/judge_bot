import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:judge_bot/src/api/ninja/objects.dart';
import 'package:judge_bot/src/api/ninja/variables.dart';
import 'package:nyxx_commander/nyxx_commander.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

Future<void> leagueSetCommand(ICommandContext ctx, String content) async {

  if (ctx.author.id.id == 97837550491664384) {
    try {
      // String league = event
      //     .getArg('league')
      //     .value
      //     .toString();
      String leagueName = content.replaceFirst('\$league ', '');

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

      ctx.reply(ComponentMessageBuilder()..content = 'Updated league to $leagueName');
    } catch (e) {
      ctx.reply(ComponentMessageBuilder()..content = 'Error setting league to $leagueName:\n $e');
    }
  } else {
    ctx.reply(ComponentMessageBuilder()..content = 'You\'re not Andy.');
  }
}