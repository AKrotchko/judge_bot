import 'package:judge_bot/judge_bot.dart';
import 'package:judge_bot/src/api/ninja/objects.dart';
import 'package:judge_bot/src/api/ninja/variables.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:string_similarity/string_similarity.dart';

Future<void> priceCheckSlashHandler(ISlashCommandInteractionEvent event) async {
  if (ninjaItems.isNotEmpty) {
    String searchTerm = event.getArg('name').value.toString();

    if (searchTerm.isNotEmpty) {
      var matches =
          searchTerm.bestMatch(ninjaItems.map((e) => e.name).toList());

      final embed = EmbedBuilder()
        ..color = DiscordColor.azure
        ..title = ninjaItems[matches.bestMatchIndex].name
        ..thumbnailUrl = ninjaItems[matches.bestMatchIndex].icon
        ..addField(name: 'Price:', content: 'Loading...');

      await event.respond(MessageBuilder.embed(embed));

      /// Checks for cached items, or fetches if they're old
      bool success = await fetchNinjaItems(ninjaItems[matches.bestMatchIndex].type);

      if (success) {
        /// Does a replacement for currency
        if (ninjaItems[matches.bestMatchIndex].type == 'Currency') {
          String price = ninjaCurrency
              .firstWhere(
                  (element) =>
              element.name == ninjaItems[matches.bestMatchIndex].name,
              orElse: () => CurrencyItem(name: 'Unknown', price: 0))
              .price
              .toString();

          embed.replaceField(name: 'Price:', content: 'Chaos Equivalent: $price');
        } else if (ninjaItems[matches.bestMatchIndex].type == 'Fragment') {
          String price = ninjaFragments
              .firstWhere(
              (element) =>
                  element.name == ninjaItems[matches.bestMatchIndex].name,
            orElse: () => CurrencyItem(name: 'Unknown', price: 0))
              .price
              .toString();

          embed.replaceField(name: 'Price:', content: 'Chaos Equivalent: $price');
        }
      } else {
        embed.replaceField(name: 'Price:', content: 'Failed to load (Or unsupported)');
      }

      await event.editOriginalResponse(MessageBuilder.embed(embed));

    } else {
      await event
          .respond(MessageBuilder.content('Please provide an item name'));
    }
  } else {
    await event.respond(
        MessageBuilder.content('My database is empty... Let Andy know.'));
  }
}
