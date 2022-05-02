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

      var embed = EmbedBuilder()
        ..color = DiscordColor.azure
        ..title = ninjaItems[matches.bestMatchIndex].name
        ..url =
            'https://www.poewiki.net/wiki/${(ninjaItems[matches.bestMatchIndex].name).replaceAll(' ', '_')}'
        ..thumbnailUrl = ninjaItems[matches.bestMatchIndex].icon;

      await event.respond(MessageBuilder.embed(embed));

      /// Checks for cached items, or fetches if they're old
      bool success =
          await fetchNinjaItems(ninjaItems[matches.bestMatchIndex].type);

      /// If the item is supported, and either cached or fetched
      if (success) {
        switch (ninjaItems[matches.bestMatchIndex].type) {
          case 'Currency':
            {
              String price = ninjaCurrency
                  .firstWhere(
                      (element) =>
                          element.name ==
                          ninjaItems[matches.bestMatchIndex].name,
                      orElse: () => CurrencyItem(name: 'Unknown', price: 0))
                  .price
                  .toString();

              embed.replaceField(
                  name: 'Price:', content: 'Chaos Equivalent: $price');
              break;
            }
          case 'Fragment':
            {
              String price = ninjaFragments
                  .firstWhere(
                      (element) =>
                          element.name ==
                          ninjaItems[matches.bestMatchIndex].name,
                      orElse: () => CurrencyItem(name: 'Unknown', price: 0))
                  .price
                  .toString();

              embed.replaceField(
                  name: 'Price:', content: 'Chaos Equivalent: $price');
              break;
            }
          case 'DivinationCard':
            {
              DivCard divCard = ninjaDivCards.firstWhere(
                  (element) =>
                      element.name == ninjaItems[matches.bestMatchIndex].name,
                  orElse: () => DivCard(
                      name: 'Unknown',
                      stackSize: 0,
                      artFilename: '',
                      flavourText: '',
                      chaosValue: 0,
                      exaltedValue: 0,
                      listingCount: 0));

              embed = EmbedBuilder()
                ..addFooter((footer) {
                  footer.text = divCard.flavourText;
                })
                ..color = DiscordColor.azure
                ..title = ninjaItems[matches.bestMatchIndex].name
                ..url =
                    'https://www.poewiki.net/wiki/${(ninjaItems[matches.bestMatchIndex].name).replaceAll(' ', '_')}'
                ..thumbnailUrl = ninjaItems[matches.bestMatchIndex].icon
                ..imageUrl =
                    'https://web.poecdn.com/image/divination-card/${divCard.artFilename}.png'
                ..addField(
                    name: 'Stack Size:', content: divCard.stackSize.toString())
                ..addField(
                    name: 'Chaos Value:',
                    content: '${divCard.chaosValue}',
                    inline: true)
                ..addField(
                    name: 'Exalted Value:',
                    content: '${divCard.exaltedValue}',
                    inline: true)
                ..addField(
                    name: 'Total Listed:',
                    content: '${divCard.listingCount}',
                    inline: true);
              break;
            }
          case 'Artifact':
            {
              Artifact artifact = ninjaArtifacts.firstWhere(
                  (element) =>
                      element.name == ninjaItems[matches.bestMatchIndex].name,
                  orElse: () => Artifact(
                      name: 'Unknown',
                      chaosValue: 0,
                      exaltedValue: 0,
                      listingCount: 0));

              embed.addField(
                  name: 'Total Listed:',
                  content: '${artifact.listingCount}');
              embed.addField(
                  name: 'Chaos Value:',
                  content: '${artifact.chaosValue}',
                  inline: true);
                embed.addField(
                    name: 'Exalted Value:',
                    content: '${artifact.exaltedValue}',
                    inline: true);
                break;
            }
        }
      } else {
        embed.replaceField(
            name: 'Price:', content: 'Failed to load (Or unsupported)');
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
