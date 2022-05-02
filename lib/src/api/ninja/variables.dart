import 'package:judge_bot/src/api/ninja/objects.dart';

/// This whole file is static variables... I should proooobably fix that.

// ToDo - Allow bot to get current league dynamically, and maybe even swap leagues?
String league = 'Archnemesis';

/// Cached list of every item recognized by poe.ninja. Used for searching, and
/// cross-referencing the poe.ninja API
List<NinjaItem> ninjaItems = [];

/// List of all currency items, and the time that we last fetched them
DateTime ninjaCurrencyLastUpdated = DateTime(1970);
List<CurrencyItem> ninjaCurrency = [];

/// List of all fragment items, and the time that we last fetched them
DateTime ninjaCurrenciesLastUpdated = DateTime(1970);
List<CurrencyItem> ninjaFragments = [];

/// List of all div cards, and the time that we last fetched them
DateTime ninjaDivCardsLastUpdated = DateTime(1970);
List<DivCard> ninjaDivCards = [];