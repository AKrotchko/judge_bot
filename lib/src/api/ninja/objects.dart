class NinjaItem {
  final String type;
  final String name;
  final String icon;

  NinjaItem({required this.type, required this.name, required this.icon});
}

class CurrencyItem {
  final String name;
  final double? price;

  CurrencyItem({required this.name, required this.price});
}

class DivCard {
  final String name;
  final int? stackSize;
  final String artFilename;
  final String flavourText;
  final double? chaosValue;
  final double? exaltedValue;
  final int? listingCount;

  DivCard(
      {required this.name,
      required this.stackSize,
      required this.artFilename,
      required this.flavourText,
      required this.chaosValue,
      required this.exaltedValue,
      required this.listingCount});
}

class GenericItem {
  final String name;
  final double? chaosValue;
  final double? exaltedValue;
  final int? listingCount;

  GenericItem(
      {required this.name,
      required this.chaosValue,
      required this.exaltedValue,
      required this.listingCount});
}

class UniqueItem {
  final String name;
  final String baseType;
  final String flavourText;
  final String itemType;
  final double? chaosValue;
  final double? exaltedValue;
  final int? listingCount;

  UniqueItem(
      {required this.name,
      required this.baseType,
      required this.flavourText,
      required this.itemType,
      required this.chaosValue,
      required this.exaltedValue,
      required this.listingCount});
}

class SkillGem {
  final String name;
  final String icon;
  final int? levelRequired;
  final int? gemLevel;
  final int? gemQuality;
  final double? chaosValue;
  final double? exaltedValue;
  final int? listingCount;

  SkillGem({
    required this.name,
    required this.icon,
    required this.levelRequired,
    required this.gemLevel,
    required this.gemQuality,
    required this.chaosValue,
    required this.exaltedValue,
    required this.listingCount,
  });
}
