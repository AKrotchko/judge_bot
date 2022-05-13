import 'package:judge_bot/src/api/ninja/objects.dart';

/// This whole file is static variables... I should proooobably fix that.

// ToDo - Allow bot to get current league dynamically, and maybe even swap leagues?
// String league = 'Archnemesis';
String league = 'Sentinel';

/// Cached list of every item recognized by poe.ninja. Used for searching, and
/// cross-referencing the poe.ninja API
List<NinjaItem> ninjaItems = [];

/// List of all currency items, and the time that we last fetched them
DateTime ninjaCurrencyLastUpdated = DateTime(1970);
List<CurrencyItem> ninjaCurrency = [];

/// List of all fragment items, and the time that we last fetched them
DateTime ninjaFragmentsLastUpdated = DateTime(1970);
List<CurrencyItem> ninjaFragments = [];

/// List of all div cards, and the time that we last fetched them
DateTime ninjaDivCardsLastUpdated = DateTime(1970);
List<DivCard> ninjaDivCards = [];

/// List of all artifacts, and the time that we last fetched them
DateTime ninjaArtifactsLastUpdated = DateTime(1970);
List<GenericItem> ninjaArtifacts = [];

/// List of all oils, and the time that we last fetched them
DateTime ninjaOilsLastUpdated = DateTime(1970);
List<GenericItem> ninjaOils = [];

/// List of all incubators, and the time that we last fetched them
DateTime ninjaIncubatorsLastUpdated = DateTime(1970);
List<GenericItem> ninjaIncubators = [];

/// List of all unique weapons, and the time that we last fetched them
DateTime ninjaUniqueWeaponsLastUpdated = DateTime(1970);
List<UniqueItem> ninjaUniqueWeapons = [];

/// List of all unique armour, and the time that we last fetched them
DateTime ninjaUniqueArmourLastUpdated = DateTime(1970);
List<UniqueItem> ninjaUniqueArmour = [];

/// List of all unique jewellery, and the time that we last fetched them
DateTime ninjaUniqueAccessoriesLastUpdated = DateTime(1970);
List<UniqueItem> ninjaUniqueAccessories = [];

/// List of all unique flasks, and the time that we last fetched them
DateTime ninjaUniqueFlasksLastUpdated = DateTime(1970);
List<UniqueItem> ninjaUniqueFlasks = [];

/// List of all unique jewels, and the time that we last fetched them
DateTime ninjaUniqueJewelsLastUpdated = DateTime(1970);
List<UniqueItem> ninjaUniqueJewels = [];

/// List of all skill gems, and the time that we last fetched them
DateTime ninjaSkillGemsLastUpdated = DateTime(1970);
List<SkillGem> ninjaSkillGems = [];

/// List of all cluster jewels, and the time that we last fetched them
DateTime ninjaClusterJewelsLastUpdated = DateTime(1970);
List<ClusterJewel> ninjaClusterJewels = [];

/// List of all maps, and the time that we last fetched them
DateTime ninjaMapsLastUpdated = DateTime(1970);
List<MapItem> ninjaMaps = [];

/// List of all blighted maps, and the time that we last fetched them
DateTime ninjaBlightedMapsLastUpdated = DateTime(1970);
List<MapItem> ninjaBlightedMaps = [];

/// List of all blight-ravaged maps, and the time that we last fetched them
DateTime ninjaBlightRavagedMapsLastUpdated = DateTime(1970);
List<MapItem> ninjaBlightRavagedMaps = [];

/// List of all unique maps, and the time that we last fetched them
DateTime ninjaUniqueMapsLastUpdated = DateTime(1970);
List<UniqueMapItem> ninjaUniqueMaps = [];

/// List of all delirium orbs, and the time that we last fetched them
DateTime ninjaDeliriumOrbsLastUpdated = DateTime(1970);
List<GenericItem> ninjaDeliriumOrbs = [];

/// List of all invitations, and the time that we last fetched them
DateTime ninjaInvitationsLastUpdated = DateTime(1970);
List<GenericFlavourItem> ninjaInvitations = [];

/// List of all scarabs, and the time that we last fetched them
DateTime ninjaScarabsLastUpdated = DateTime(1970);
List<GenericFlavourItem> ninjaScarabs = [];
