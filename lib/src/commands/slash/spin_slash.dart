import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

Future<void> spinSlashHandler(ISlashCommandInteractionEvent event) async {
  List<String> builds = [
    'Boneshatter Slayer',
    'Boneshatter Juggernaut',
    'Cold DoT Elementalist',
    'Cold DoT Occultist',
    'Corrupting Fever Champion',
    'Detonate Dead Elementalist',
    'Explosive Arrow Champion',
    'Explosive Arrow Elementalist',
    'Fire Trap Elementalist',
    'Freezing Pulse/Ice Spear Totem Hierophant',
    'Frost Blades Trickster',
    'Hexblast Mines Saboteur',
    'Ice Shot Deadeye',
    'Impending Doom Occultist',
    'Lightning Arrow Deadeye',
    'Lightning Conduit Elementalist',
    'Poison Blade Vortex Occultist',
    'Poison Blade Vortex Pathfinder',
    'Poison Summon Raging Spirits Necromancer',
    'Pyroclast Mine Saboteur',
    'Rain of Arrows Champion',
    'Righteous Fire Juggernaut',
    'Righteous Fire Inquisitor',
    'Spark Inquisitor',
    'Spectral Shield Throw Trickster',
    'Toxic Rain Pathfinder',
    'Venom Gyre Deadeye',
    'Wave of Conviction Ignite Elementalist',
  ];

  /// Chooses a random number the size of the builds list
  int randomInt = Random().nextInt(builds.length);

  await event.respond(MessageBuilder.content(builds[randomInt]));
}