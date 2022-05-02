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
