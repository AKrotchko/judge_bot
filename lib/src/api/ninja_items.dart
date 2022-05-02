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
    default:
      return false;
  }
}
