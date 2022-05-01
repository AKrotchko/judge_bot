import 'dart:math';

import 'package:nyxx/nyxx.dart';

/// Bot spits out copypastas. Adding more is easy. They're all really dumb.
Future<void> pasta(IMessageReceivedEvent event) async {
  int randomInt = Random().nextInt(100000);

  switch (randomInt) {
    case 1:
      reply('Fuck Water', event);
      break;
    case 2:
      reply('I don\'t care for CHAINING', event);
      break;
    case 3:
      reply('But, with a good carry, Omega is pretty fucking easy.', event);
      break;
    case 4:
      reply('Now let\'s go back to reality for a moment. Everything I said about Kaito was backed up by Fujimoto-san himself when I asked him specifically about Kaito and the ideas behind his design. Unique, variety, powerful, balance, synergy all came out but none of the crap you\'re trying to spit out.', event);
      break;
    case 5:
      reply('All I know what to do anymore is fucking water, it\'s been so long. I don\'t know what fuck is anymore. The other day, I tried to fuck water. With actual warer. Everything has become fuck water to me. There are no other fuck, no liquid other than water. The only fuck I know how to is fuck water. Occasionally I don’t fuck water, and I cry a little. I fuck water but wish water was fucking me instead. It\'s become a fuck of sorts, or maybe it\'s just water. I can\'t go anywhere without seeing fuck water. I went to feed my dog the other night, but instead of eating she fuck water. I had to put her down. I sit in the corner now counting down the days, the days where we shall see sweet release from this torment, the day when fucking was about you and your partner having a special bond and creating something beautiful. Those days are long gone. I have seen God, and I have seen the devil, but they are one and the same. I stared into the abyss and screamed, and it screamed back: "Fuck water".', event);
      break;
    case 6:
      reply('Who said I\'m not relaxed? Nothing in my message was at all hostile so you should probably chill, goofy. Lmfao.\n'
          '\n'
          'You do get 5* ticks from JP. Log in right now and check the KH event.\n'
          '\n'
          'You should probably learn to read; the obvious implication of 2 wasn\'t "you don\'t like NV is coming ever", it was referring to your belief it won\'t come on the 20th.\n'
          '\n'
          'They can do bait but they probably won\'t unless it is DFK or a GLEX. They are building the Next Era shit as a Neovisions release so it\'ll prolly release with Overdrive (which is the 20th). Like I said, either the 20th or the maint after if we get a GLEX or collab (both I would say are unlikely.)\n'
          '@Vactro', event);
      break;
    case 7:
      reply('request: remove " :blobblush: " for it\'s a toxic emoticon that promotes an unhealthy community. it\'s used in a very condescending manner and forces a certain perspective when interpreting someones intent. Much similar to the " :megu: " emote, which is primarily used in contexts which warrant mod intervention, for it\'s blatant overuse with innuendos and toxic behaviour.', event);
      break;
    case 8:
      reply('what am I gonna get ban? you cant ban me if I am not here bitch', event);
      break;
    case 9:
      reply('I would just like to say that Hazard is the best mod ever.  Trap is good but Hazard is best.  He cares for us like all the rest.  He is like the Beowulf to our Grendel.  Without him we would all be in darkness.  Please join me in saying long live Hazard.  May he mod us with impunity forever.  Also I would like to give a shout out to the big man upstairs.  You know who I am talking about.  Evil Laughter 01.  Yeah it is so great he\'s back.  Without him life was darkness.', event);
      break;
    case 10:
      reply('Well in my opinion Foo is best support unit in the entire ffbe game. He can spam no refill (200 and could be double casted so you have 400 mp for all party) he can give your entire team Full LB through his Magnus. He does elemental resist, mitigations and breaking. He has entrust on top of that and a mag aoe cover tank when you need it. He has everything. Best unit I pulled for ever. I even got him stmrd', event);
      break;
    case 11:
      reply('The People who run the Reddit/Wiki/Discord gets paid by Gumi!\n'
          '\n'
          'They are a bunch of fake lonely people that gets paid by Gumi. Except Baros of course. He gets paid with gay feet pics. This is such a dead toxic whipped community. Why do the users put up with it. Just make their registration 0. Unjointed the groupd. #Your work is meaningless. Only Lygard is cool! Oh and the Asian chick voice sounds ok. I would give her half a date to prove herself. Dream blitz is still in the back of the classroom failing math test because he doesn\'t think fast enough!!!!!', event);
      break;
    case 12:
      reply('H: Alright so umm, Mr. Blair Witch himself, chain link fence in the back. So between the 2 games you work on, cause you play them both, i know you play them both, try to keep up on, cause what kind of community manager would you be if you didn\'t play the games you manage right? I know you play them both, we talked about that before. So out of those 2 games, there\'s gotta be one, everyone has the one that got away, which character did you really want, between FFBE and WoTV, probably FFBE, what character did you want but you couldn\'t get? Cause people here know that there\'s a couple ones that got away from me. I got real lucky but there\'s a couple that got away from me. Especially recently. Especially Aphmau, who I\'m a FF11 fan, but just get the tickets alright. Geez, I just want my puppet master, as a puppet master main, as a puppet master character, I want the puppet master character from the puppet master game, but which one got away from you?', event);
      break;
    case 13:
      reply('Howl: We live? We are living this? Joe Rogan style dude. What\'s up. How you doing man? How you doing in the DAARKNEESSS Charlie Murphy?\n'
          'Justin: I\'m doing alright\n'
          'Howl: You in the DAARRKNESSSS\n'
          'Justin: I am, it was as he mentioned earlier, it was daylight when we jumped into the call, but it is no longer daylight\n'
          'Howl: It did, it did, I saw a couple like ghost behind you at some point. You know. It was very scary. You didn\'t see them.', event);
      break;

  }
}

reply(String message, IMessageReceivedEvent event) async {
  event.message.channel
      .sendMessage(MessageBuilder.content(message));
}