import 'package:judge_bot/judge_bot.dart';
import 'package:judge_bot/src/api/ninja/objects.dart';
import 'package:judge_bot/src/api/ninja/variables.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:string_similarity/string_similarity.dart';

Future<void> priceCheckSlashHandler(ISlashCommandInteractionEvent event) async {
  try {
    if (ninjaItems.isNotEmpty) {
      String searchTerm = event.getArg('name').value.toString();

      if (searchTerm.isNotEmpty) {
        var matches =
            searchTerm.bestMatch(ninjaItems.map((e) => e.name).toList());

        var embed = EmbedBuilder()
          ..addAuthor((author) {
            author.name = 'View on PoE Wiki';
            author.url =
                'https://www.poewiki.net/wiki/${(ninjaItems[matches.bestMatchIndex].name).replaceAll(' ', '_')}';
          })
          ..color = DiscordColor.azure
          ..title = ninjaItems[matches.bestMatchIndex].name
          ..url = getPoeNinjaItemLink(
              itemName: ninjaItems[matches.bestMatchIndex].name,
              itemType: ninjaItems[matches.bestMatchIndex].type)
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
                        divineValue: 0,
                        listingCount: 0));

                embed = EmbedBuilder()
                  ..addAuthor((author) {
                    author.name = 'View on PoE Wiki';
                    author.url =
                        'https://www.poewiki.net/wiki/${(ninjaItems[matches.bestMatchIndex].name).replaceAll(' ', '_')}';
                  })
                  ..addFooter((footer) {
                    footer.text = divCard.flavourText;
                  })
                  ..color = DiscordColor.azure
                  ..title = ninjaItems[matches.bestMatchIndex].name
                  ..url = getPoeNinjaItemLink(
                      itemName: ninjaItems[matches.bestMatchIndex].name,
                      itemType: ninjaItems[matches.bestMatchIndex].type)
                  ..thumbnailUrl = ninjaItems[matches.bestMatchIndex].icon
                  ..imageUrl =
                      'https://web.poecdn.com/image/divination-card/${divCard.artFilename}.png'
                  ..addField(
                      name: 'Stack Size:',
                      content: divCard.stackSize.toString())
                  ..addField(
                      name: 'Chaos Value:',
                      content: '${divCard.chaosValue}',
                      inline: true)
                  ..addField(
                      name: 'Divine Value:',
                      content: '${divCard.divineValue}',
                      inline: true)
                  ..addField(
                      name: 'Total Listed:',
                      content: '${divCard.listingCount}',
                      inline: true);
                break;
              }
            case 'Artifact':
              {
                GenericItem artifact = ninjaArtifacts.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => GenericItem(
                        name: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:', content: '${artifact.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${artifact.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${artifact.divineValue}',
                    inline: true);
                break;
              }
            case 'Oil':
              {
                GenericItem oil = ninjaOils.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => GenericItem(
                        name: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:', content: '${oil.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${oil.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${oil.divineValue}',
                    inline: true);
                break;
              }
            case 'Incubator':
              {
                GenericItem incubator = ninjaIncubators.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => GenericItem(
                        name: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:',
                    content: '${incubator.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${incubator.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${incubator.divineValue}',
                    inline: true);
                break;
              }
            case 'UniqueWeapon':
              {
                UniqueItem uniqueWeapon = ninjaUniqueWeapons.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => UniqueItem(
                          name: 'Unknown',
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          listingCount: 0,
                          itemType: 'Unknown',
                          baseType: 'Unknown',
                          flavourText: 'Unknown',
                        ));

                embed.title = '${uniqueWeapon.name} - ${uniqueWeapon.itemType}';
                embed.addFooter((footer) {
                  footer.text = uniqueWeapon.flavourText;
                });
                embed.description = uniqueWeapon.baseType;

                embed.addField(
                    name: 'Total Listed:',
                    content: '${uniqueWeapon.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${uniqueWeapon.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${uniqueWeapon.divineValue}',
                    inline: true);
                break;
              }
            case 'UniqueArmour':
              {
                UniqueItem uniqueArmour = ninjaUniqueArmour.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => UniqueItem(
                          name: 'Unknown',
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          listingCount: 0,
                          itemType: 'Unknown',
                          baseType: 'Unknown',
                          flavourText: 'Unknown',
                        ));

                embed.title = '${uniqueArmour.name} - ${uniqueArmour.itemType}';
                embed.addFooter((footer) {
                  footer.text = uniqueArmour.flavourText;
                });
                embed.description = uniqueArmour.baseType;

                embed.addField(
                    name: 'Total Listed:',
                    content: '${uniqueArmour.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${uniqueArmour.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${uniqueArmour.divineValue}',
                    inline: true);
                break;
              }
            case 'UniqueAccessory':
              {
                UniqueItem uniqueAccessory = ninjaUniqueAccessories.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => UniqueItem(
                          name: 'Unknown',
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          listingCount: 0,
                          itemType: 'Unknown',
                          baseType: 'Unknown',
                          flavourText: 'Unknown',
                        ));

                embed.title =
                    '${uniqueAccessory.name} - ${uniqueAccessory.itemType}';
                embed.addFooter((footer) {
                  footer.text = uniqueAccessory.flavourText;
                });
                embed.description = uniqueAccessory.baseType;

                embed.addField(
                    name: 'Total Listed:',
                    content: '${uniqueAccessory.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${uniqueAccessory.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${uniqueAccessory.divineValue}',
                    inline: true);
                break;
              }
            case 'UniqueFlask':
              {
                UniqueItem uniqueFlask = ninjaUniqueFlasks.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => UniqueItem(
                          name: 'Unknown',
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          listingCount: 0,
                          itemType: 'Unknown',
                          baseType: 'Unknown',
                          flavourText: 'Unknown',
                        ));

                embed.title = '${uniqueFlask.name} - ${uniqueFlask.itemType}';
                embed.addFooter((footer) {
                  footer.text = uniqueFlask.flavourText;
                });
                embed.description = uniqueFlask.baseType;

                embed.addField(
                    name: 'Total Listed:',
                    content: '${uniqueFlask.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${uniqueFlask.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${uniqueFlask.divineValue}',
                    inline: true);
                break;
              }
            case 'UniqueJewel':
              {
                UniqueItem uniqueJewel = ninjaUniqueJewels.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => UniqueItem(
                          name: 'Unknown',
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          listingCount: 0,
                          itemType: 'Unknown',
                          baseType: 'Unknown',
                          flavourText: 'Unknown',
                        ));

                embed.title = '${uniqueJewel.name} - ${uniqueJewel.itemType}';
                embed.addFooter((footer) {
                  footer.text = uniqueJewel.flavourText;
                });
                embed.description = uniqueJewel.baseType;

                embed.addField(
                    name: 'Total Listed:',
                    content: '${uniqueJewel.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${uniqueJewel.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${uniqueJewel.divineValue}',
                    inline: true);
                break;
              }
            case 'SkillGem':
              {
                SkillGem skillGem = ninjaSkillGems.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => SkillGem(
                          name: 'Unknown',
                          icon: 'Unknown',
                          levelRequired: 0,
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          gemLevel: 0,
                          gemQuality: 0,
                          listingCount: 0,
                        ));

                embed.title = skillGem.name;
                embed.addField(
                  name: 'Total Listed:',
                  content: '${skillGem.listingCount}',
                );
                embed.addField(
                  name: 'Level Required:',
                  content: '${skillGem.levelRequired}',
                  inline: true,
                );
                embed.addField(
                  name: 'Gem Level:',
                  content: '${skillGem.gemLevel}',
                  inline: true,
                );
                embed.addField(
                  name: 'Gem Quality:',
                  content: '${skillGem.gemQuality}',
                  inline: true,
                );
                embed.addField(
                  name: 'Chaos Value:',
                  content: '${skillGem.chaosValue}',
                  inline: true,
                );
                embed.addField(
                  name: 'Divine Value:',
                  content: '${skillGem.divineValue}',
                  inline: true,
                );
                break;
              }
            case 'ClusterJewel':
              {
                ClusterJewel clusterJewel = ninjaClusterJewels.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => ClusterJewel(
                          name: 'Unknown',
                          icon: 'Unknown',
                          levelRequired: 0,
                          chaosValue: 0,
                          exaltedValue: 0,
                          divineValue: 0,
                          listingCount: 0,
                          baseType: 'Unknown',
                          variant: 'Unknown',
                        ));

                embed.title =
                    '${clusterJewel.variant.replaceFirst('passives', 'passive')} ${clusterJewel.baseType}';
                embed.description = clusterJewel.name;

                /// Removes the poewiki header from generic cluster jewels
                embed.author = null;

                embed.addField(
                  name: 'Total Listed:',
                  content: '${clusterJewel.listingCount}',
                );
                embed.addField(
                  name: 'Level Required:',
                  content: '${clusterJewel.levelRequired}',
                  inline: true,
                );
                embed.addField(
                  name: 'Chaos Value:',
                  content: '${clusterJewel.chaosValue}',
                  inline: true,
                );
                embed.addField(
                  name: 'Divine Value:',
                  content: '${clusterJewel.divineValue}',
                  inline: true,
                );
                break;
              }
            case 'Map':
              {
                MapItem map = ninjaMaps.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => MapItem(
                        name: 'Unknown',
                        mapTier: 0,
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:', content: '${map.listingCount}');
                embed.addField(
                  name: 'Map Tier:',
                  content: '${map.mapTier}',
                  inline: true,
                );
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${map.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${map.divineValue}',
                    inline: true);
                break;
              }
            case 'BlightedMap':
              {
                MapItem blightedMap = ninjaBlightedMaps.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => MapItem(
                        name: 'Unknown',
                        mapTier: 0,
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:',
                    content: '${blightedMap.listingCount}');
                embed.addField(
                  name: 'Map Tier:',
                  content: '${blightedMap.mapTier}',
                  inline: true,
                );
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${blightedMap.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${blightedMap.divineValue}',
                    inline: true);
                break;
              }
            case 'BlightRavagedMap':
              {
                MapItem blightedMap = ninjaBlightRavagedMaps.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => MapItem(
                        name: 'Unknown',
                        mapTier: 0,
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:',
                    content: '${blightedMap.listingCount}');
                embed.addField(
                  name: 'Map Tier:',
                  content: '${blightedMap.mapTier}',
                  inline: true,
                );
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${blightedMap.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${blightedMap.divineValue}',
                    inline: true);
                break;
              }
            case 'UniqueMap':
              {
                UniqueMapItem uniqueMap = ninjaUniqueMaps.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => UniqueMapItem(
                        name: 'Unknown',
                        mapTier: 0,
                        baseType: 'Unknown',
                        flavourText: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.title = uniqueMap.name;
                embed.description = uniqueMap.baseType;

                embed.addField(
                  name: 'Total Listed:',
                  content: '${uniqueMap.listingCount}',
                );

                embed.addField(
                  name: 'Map Tier:',
                  content: '${uniqueMap.mapTier}',
                  inline: true,
                );
                embed.addField(
                  name: 'Chaos Value:',
                  content: '${uniqueMap.chaosValue}',
                  inline: true,
                );
                embed.addField(
                  name: 'Divine Value:',
                  content: '${uniqueMap.divineValue}',
                  inline: true,
                );

                embed.addFooter((footer) {
                  footer.text = uniqueMap.flavourText;
                });
                break;
              }
            case 'DeliriumOrb':
              {
                GenericItem deliriumOrb = ninjaDeliriumOrbs.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => GenericItem(
                        name: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.addField(
                    name: 'Total Listed:',
                    content: '${deliriumOrb.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${deliriumOrb.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${deliriumOrb.divineValue}',
                    inline: true);
                break;
              }
            case 'Invitation':
              {
                GenericFlavourItem invitation = ninjaInvitations.firstWhere(
                    (element) =>
                        element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => GenericFlavourItem(
                        name: 'Unknown',
                        flavourText: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.title = invitation.name;
                embed.addField(
                    name: 'Total Listed:',
                    content: '${invitation.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${invitation.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${invitation.divineValue}',
                    inline: true);

                embed.addFooter((footer) {
                  footer.text = invitation.flavourText;
                });
                break;
              }
            case 'Scarab':
              {
                GenericFlavourItem scarab = ninjaScarabs.firstWhere(
                        (element) =>
                    element.name == ninjaItems[matches.bestMatchIndex].name,
                    orElse: () => GenericFlavourItem(
                        name: 'Unknown',
                        flavourText: 'Unknown',
                        chaosValue: 0,
                        exaltedValue: 0,
                        divineValue: 0,
                        listingCount: 0));

                embed.title = scarab.name;
                embed.addField(
                    name: 'Total Listed:',
                    content: '${scarab.listingCount}');
                embed.addField(
                    name: 'Chaos Value:',
                    content: '${scarab.chaosValue}',
                    inline: true);
                embed.addField(
                    name: 'Divine Value:',
                    content: '${scarab.divineValue}',
                    inline: true);

                embed.addFooter((footer) {
                  footer.text = scarab.flavourText;
                });
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
  } catch (e) {
    /// Catches any erroneous errors, preventing the bot from crashing.
    print('An error occurred when trying to price check: $e');
    await event.respond(MessageBuilder.content('Something went wrong... $e'));
  }
}

String getPoeNinjaItemLink(
    {required String itemType, required String itemName}) {
  String baseUrl = 'https://poe.ninja/challenge';

  String itemNameUrlSafe = itemName.replaceAll(' ', '%20');
  itemNameUrlSafe = itemNameUrlSafe.replaceAll('\'', '%27');

  switch (itemType) {
    case 'Currency':
      return '$baseUrl/currency?name=$itemNameUrlSafe';
    case 'Fragment':
      return '$baseUrl/fragments?name=$itemNameUrlSafe';
    case 'DivinationCard':
      return '$baseUrl/divination-cards?name=$itemNameUrlSafe';
    case 'Artifact':
      return '$baseUrl/artifacts?name=$itemNameUrlSafe';
    case 'Prophecy':
      return '$baseUrl/prophecies?name=$itemNameUrlSafe';
    case 'Oil':
      return '$baseUrl/oils?name=$itemNameUrlSafe';
    case 'Incubator':
      return '$baseUrl/incubators?name=$itemNameUrlSafe';
    case 'UniqueWeapon':
      return '$baseUrl/unique-weapons?name=$itemNameUrlSafe';
    case 'UniqueArmour':
      return '$baseUrl/unique-armours?name=$itemNameUrlSafe';
    case 'UniqueAccessory':
      return '$baseUrl/unique-accessories?name=$itemNameUrlSafe';
    case 'UniqueFlask':
      return '$baseUrl/unique-flasks?name=$itemNameUrlSafe';
    case 'UniqueJewel':
      return '$baseUrl/unique-jewels?name=$itemNameUrlSafe';
    case 'SkillGem':
      return '$baseUrl/skill-gems?name=$itemNameUrlSafe';
    case 'ClusterJewel':
      return '$baseUrl/cluster-jewels?name=$itemNameUrlSafe';
    case 'Map':
      return '$baseUrl/maps?name=$itemNameUrlSafe';
    case 'BlightedMap':
      return '$baseUrl/blighted-maps?name=$itemNameUrlSafe';
    case 'BlightRavagedMap':
      return '$baseUrl/blight-ravaged-maps?name=$itemNameUrlSafe';
    case 'ScourgedMap':
      return '$baseUrl/scourged-maps?name=$itemNameUrlSafe';
    case 'UniqueMap':
      return '$baseUrl/unique-maps?name=$itemNameUrlSafe';
    case 'DeliriumOrb':
      return '$baseUrl/delirium-orbs?name=$itemNameUrlSafe';
    case 'Invitation':
      return '$baseUrl/invitations?name=$itemNameUrlSafe';
    case 'Scarab':
      return '$baseUrl/scarabs?name=$itemNameUrlSafe';
    case 'Watchstone':
      return '$baseUrl/watchstones?name=$itemNameUrlSafe';
    case 'BaseType':
      return '$baseUrl/base-types?name=$itemNameUrlSafe';
    case 'Fossil':
      return '$baseUrl/fossils?name=$itemNameUrlSafe';
    case 'Resonator':
      return '$baseUrl/resonators?name=$itemNameUrlSafe';
    case 'HelmetEnchant':
      return '$baseUrl/helmet-enchantments?name=$itemNameUrlSafe';
    case 'Beast':
      return '$baseUrl/beasts?name=$itemNameUrlSafe';
    case 'Essence':
      return '$baseUrl/essences?name=$itemNameUrlSafe';
    case 'Vial':
      return '$baseUrl/vials?name=$itemNameUrlSafe';
    default:
      return '$baseUrl/currency';
  }
}
