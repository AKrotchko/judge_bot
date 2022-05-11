import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:judge_bot/src/api/ninja/objects.dart';
import 'package:judge_bot/src/api/ninja/variables.dart';

/// Asks for every single item from poe.ninja
// ToDo - Add a try-catch block to handle any API errors, attempt to retry
loadNinjaData() async {
  print('Fetching data from poe.ninja...');

  var url = Uri.parse(
      'https://poe.ninja/api/data/economysearch?league=$league&languages=en');

  var response = await http.get(url);
  print('Processing data from poe.ninja...');
  var data = json.decode(response.body);

  data['items'].keys.forEach((String itemType) {
    data['items'][itemType].forEach((item) {
      String type = itemType;
      String name = item['name'] ?? '';
      String icon = item['icon'] ?? '';

      ninjaItems.add(NinjaItem(type: type, name: name, icon: icon));
    });
  });

  print('Data from poe.ninja processed!');
}

/// Fetches a type of poe.ninja item. Returns true if successful, false if not
Future<bool> fetchNinjaItems(String itemType) async {
  try {
    String overviewType = '';

    if (itemType == 'Currency' || itemType == 'Fragment') {
      overviewType = 'currencyoverview';
    } else {
      overviewType = 'itemoverview';
    }

    /// Only attempt to fetch data from poe.ninja if it's been more than an hour since the last update
    if (cacheExpired(itemType)) {
      var url = Uri.parse(
          'https://poe.ninja/api/data/$overviewType?league=$league&type=$itemType');

      var response = await http.get(url);
      var data = json.decode(response.body);

      /// refill the cache with new data based on the item type
      switch (itemType) {
        case 'Currency':
          {
            ninjaCurrency = [];

            data['lines'].forEach((currency) {
              ninjaCurrency.add(CurrencyItem(
                name: currency['currencyTypeName'],
                price: double.parse(currency['chaosEquivalent'].toString()),
              ));
            });

            /// Update the last updated time
            ninjaCurrencyLastUpdated = DateTime.now();
            return true;
          }
        case 'Fragment':
          {
            ninjaFragments = [];

            data['lines'].forEach((fragment) {
              ninjaFragments.add(CurrencyItem(
                name: fragment['currencyTypeName'],
                price:
                    double.tryParse(fragment['chaosEquivalent'].toString()) ??
                        0.0,
              ));
            });

            ninjaFragmentsLastUpdated = DateTime.now();
            return true;
          }
        case 'DivinationCard':
          {
            ninjaDivCards = [];

            data['lines'].forEach((divCard) {
              ninjaDivCards.add(DivCard(
                  name: divCard['name'],
                  stackSize: int.tryParse(divCard['stackSize'].toString()) ?? 0,
                  artFilename: divCard['artFilename'],
                  flavourText: divCard['flavourText'],
                  chaosValue:
                      double.tryParse(divCard['chaosValue'].toString()) ?? 0.0,
                  exaltedValue:
                      double.tryParse(divCard['exaltedValue'].toString()) ??
                          0.0,
                  listingCount:
                      int.tryParse(divCard['listingCount'].toString()) ?? 0));
            });

            ninjaDivCardsLastUpdated = DateTime.now();
            return true;
          }
        case 'Artifact':
          {
            ninjaArtifacts = [];

            data['lines'].forEach((artifact) {
              ninjaArtifacts.add(GenericItem(
                  name: artifact['name'],
                  chaosValue: artifact['chaosValue'],
                  exaltedValue: artifact['exaltedValue'],
                  listingCount: artifact['listingCount']));
            });

            ninjaArtifactsLastUpdated = DateTime.now();
            return true;
          }
        case 'Oil':
          {
            ninjaOils = [];

            data['lines'].forEach((artifact) {
              ninjaOils.add(GenericItem(
                  name: artifact['name'],
                  chaosValue: artifact['chaosValue'],
                  exaltedValue: artifact['exaltedValue'],
                  listingCount: artifact['listingCount']));
            });

            ninjaOilsLastUpdated = DateTime.now();
            return true;
          }
        case 'Incubator':
          {
            ninjaIncubators = [];

            data['lines'].forEach((artifact) {
              ninjaIncubators.add(GenericItem(
                  name: artifact['name'],
                  chaosValue: artifact['chaosValue'],
                  exaltedValue: artifact['exaltedValue'],
                  listingCount: artifact['listingCount']));
            });

            ninjaIncubatorsLastUpdated = DateTime.now();
            return true;
          }
        case 'UniqueWeapon':
          {
            ninjaUniqueWeapons = [];

            data['lines'].forEach((uniqueWeapon) {
              ninjaUniqueWeapons.add(UniqueItem(
                  name: uniqueWeapon['name'],
                  chaosValue: uniqueWeapon['chaosValue'],
                  exaltedValue: uniqueWeapon['exaltedValue'],
                  listingCount: uniqueWeapon['listingCount'],
                  baseType: uniqueWeapon['baseType'],
                  flavourText: uniqueWeapon['flavourText'],
                  itemType: uniqueWeapon['itemType']));
            });

            ninjaUniqueWeaponsLastUpdated = DateTime.now();
            return true;
          }
        case 'UniqueArmour':
          {
            ninjaUniqueArmour = [];

            data['lines'].forEach((uniqueArmour) {
              ninjaUniqueArmour.add(UniqueItem(
                  name: uniqueArmour['name'],
                  chaosValue: uniqueArmour['chaosValue'],
                  exaltedValue: uniqueArmour['exaltedValue'],
                  listingCount: uniqueArmour['listingCount'],
                  baseType: uniqueArmour['baseType'],
                  flavourText: uniqueArmour['flavourText'],
                  itemType: uniqueArmour['itemType']));
            });

            ninjaUniqueArmourLastUpdated = DateTime.now();
            return true;
          }
        case 'UniqueAccessory':
          {
            ninjaUniqueAccessories = [];

            data['lines'].forEach((uniqueAccessory) {
              ninjaUniqueAccessories.add(UniqueItem(
                  name: uniqueAccessory['name'],
                  chaosValue: uniqueAccessory['chaosValue'],
                  exaltedValue: uniqueAccessory['exaltedValue'],
                  listingCount: uniqueAccessory['listingCount'],
                  baseType: uniqueAccessory['baseType'],
                  flavourText: uniqueAccessory['flavourText'],
                  itemType: uniqueAccessory['itemType']));
            });

            ninjaUniqueAccessoriesLastUpdated = DateTime.now();
            return true;
          }
        case 'UniqueFlask':
          {
            ninjaUniqueFlasks = [];

            data['lines'].forEach((uniqueFlask) {
              ninjaUniqueFlasks.add(UniqueItem(
                  name: uniqueFlask['name'],
                  chaosValue: uniqueFlask['chaosValue'],
                  exaltedValue: uniqueFlask['exaltedValue'],
                  listingCount: uniqueFlask['listingCount'],
                  baseType: uniqueFlask['baseType'],
                  flavourText: uniqueFlask['flavourText'],
                  itemType: 'Flask'));
            });

            ninjaUniqueFlasksLastUpdated = DateTime.now();
            return true;
          }
        case 'UniqueJewel':
          {
            ninjaUniqueJewels = [];

            data['lines'].forEach((uniqueJewel) {
              ninjaUniqueJewels.add(UniqueItem(
                  name: uniqueJewel['name'],
                  chaosValue: uniqueJewel['chaosValue'],
                  exaltedValue: uniqueJewel['exaltedValue'],
                  listingCount: uniqueJewel['listingCount'],
                  baseType: uniqueJewel['baseType'],
                  flavourText: uniqueJewel['flavourText'],
                  itemType: 'Jewel'));
            });

            ninjaUniqueJewelsLastUpdated = DateTime.now();
            return true;
          }
        case 'SkillGem':
          {
            ninjaSkillGems = [];

            data['lines'].forEach((skillGem) {
              ninjaSkillGems.add(SkillGem(
                name: skillGem['name'],
                icon: skillGem['icon'],
                levelRequired: skillGem['levelRequired'],
                gemLevel: skillGem['gemLevel'],
                gemQuality: skillGem['gemQuality'],
                chaosValue: skillGem['chaosValue'],
                exaltedValue: skillGem['exaltedValue'],
                listingCount: skillGem['listingCount'],
              ));
            });

            ninjaSkillGemsLastUpdated = DateTime.now();
            return true;
          }
        case 'ClusterJewel':
          {
            ninjaClusterJewels = [];

            data['lines'].forEach((clusterJewel) {
              ninjaClusterJewels.add(ClusterJewel(
                name: clusterJewel['name'],
                icon: clusterJewel['icon'],
                levelRequired: clusterJewel['levelRequired'],
                baseType: clusterJewel['baseType'],
                variant: clusterJewel['variant'],
                chaosValue: clusterJewel['chaosValue'],
                exaltedValue: clusterJewel['exaltedValue'],
                listingCount: clusterJewel['listingCount'],
              ));
            });

            ninjaClusterJewelsLastUpdated = DateTime.now();
            return true;
          }
        case 'Map':
          {
            ninjaMaps = [];

            data['lines'].forEach((map) {
              ninjaMaps.add(MapItem(
                name: map['name'],
                mapTier: map['mapTier'],
                listingCount: map['listingCount'],
                chaosValue: map['chaosValue'],
                exaltedValue: map['exaltedValue'],
              ));
            });

            ninjaMapsLastUpdated = DateTime.now();
            return true;
          }
        case 'BlightedMap':
          {
            ninjaBlightedMaps = [];

            data['lines'].forEach((blightedMap) {
              ninjaBlightedMaps.add(MapItem(
                name: blightedMap['name'],
                mapTier: blightedMap['mapTier'],
                listingCount: blightedMap['listingCount'],
                chaosValue: blightedMap['chaosValue'],
                exaltedValue: blightedMap['exaltedValue'],
              ));
            });

            ninjaBlightedMapsLastUpdated = DateTime.now();
            return true;
          }
        case 'BlightRavagedMap':
          {
            ninjaBlightRavagedMaps = [];

            data['lines'].forEach((blightedMap) {
              ninjaBlightRavagedMaps.add(MapItem(
                name: blightedMap['name'],
                mapTier: blightedMap['mapTier'],
                listingCount: blightedMap['listingCount'],
                chaosValue: blightedMap['chaosValue'],
                exaltedValue: blightedMap['exaltedValue'],
              ));
            });

            ninjaBlightRavagedMapsLastUpdated = DateTime.now();
            return true;
          }
        case 'UniqueMap':
          {
            ninjaUniqueMaps = [];

            data['lines'].forEach((uniqueMap) {
              ninjaUniqueMaps.add(UniqueMapItem(
                name: uniqueMap['name'],
                mapTier: uniqueMap['mapTier'],
                baseType: uniqueMap['baseType'],
                flavourText: uniqueMap['flavourText'],
                chaosValue: uniqueMap['chaosValue'],
                exaltedValue: uniqueMap['exaltedValue'],
                listingCount: uniqueMap['listingCount'],
              ));
            });

            ninjaUniqueMapsLastUpdated = DateTime.now();
            return true;
          }
        default:
          return false;
      }
    }

    return true;
  } catch (e) {
    print('Error fetching data from poe.ninja: $e');
    return false;
  }
}

/// Checks if the cached data for the given item type is expired
bool cacheExpired(itemType) {
  switch (itemType) {
    case 'Currency':
      if (DateTime.now().difference(ninjaCurrencyLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'Fragment':
      if (DateTime.now().difference(ninjaFragmentsLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'DivinationCard':
      if (DateTime.now().difference(ninjaDivCardsLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'Artifact':
      if (DateTime.now().difference(ninjaArtifactsLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'Oil':
      if (DateTime.now().difference(ninjaOilsLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'Incubator':
      if (DateTime.now().difference(ninjaIncubatorsLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'UniqueWeapon':
      if (DateTime.now().difference(ninjaUniqueWeaponsLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'UniqueArmour':
      if (DateTime.now().difference(ninjaUniqueArmourLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'UniqueAccessory':
      if (DateTime.now()
              .difference(ninjaUniqueAccessoriesLastUpdated)
              .inMinutes >
          60) {
        return true;
      }
      return false;
    case 'UniqueFlask':
      if (DateTime.now().difference(ninjaUniqueFlasksLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'UniqueJewel':
      if (DateTime.now().difference(ninjaUniqueJewelsLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'SkillGem':
      if (DateTime.now().difference(ninjaSkillGemsLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'ClusterJewel':
      if (DateTime.now().difference(ninjaClusterJewelsLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'Map':
      if (DateTime.now().difference(ninjaMapsLastUpdated).inMinutes > 60) {
        return true;
      }
      return false;
    case 'BlightedMap':
      if (DateTime.now().difference(ninjaBlightedMapsLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    case 'BlightRavagedMap':
      if (DateTime.now()
              .difference(ninjaBlightRavagedMapsLastUpdated)
              .inMinutes >
          60) {
        return true;
      }
      return false;
    case 'UniqueMap':
      if (DateTime.now().difference(ninjaUniqueMapsLastUpdated).inMinutes >
          60) {
        return true;
      }
      return false;
    default:
      return false;
  }
}
