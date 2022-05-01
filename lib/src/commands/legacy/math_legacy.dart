import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/nyxx_commander.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:petitparser/petitparser.dart';

Future<void> mathCommand(ICommandContext ctx, String content) async {
  await ctx.reply(await math(content));
}

Future<ComponentMessageBuilder> math(String content, [int shardId = 0]) async {
  return ComponentMessageBuilder()
  ..content = calcString(content.replaceAll('\$calc', ''));
}

/// https://stackoverflow.com/questions/54545102/dart-make-a-calculation-from-a-user-input-string-including-math-operators
/// Where I found this implementation, plugin, and function. Genius. I didn't do any of the work.
Parser buildParser() {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive((pattern('+-').optional() &
    digit().plus() &
    (char('.') & digit().plus()).optional() &
    (pattern('eE') & pattern('+-').optional() & digit().plus())
        .optional())
        .flatten('number expected')
        .trim()
        .map(num.tryParse))
    ..wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  builder.group().prefix(char('-').trim(), (op, a) => -a);
  builder.group().right(char('^').trim(), (a, op, b) => pow(a, b));
  builder.group()
    ..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);
  return builder.build().end();
}

double calcString(String text) {
  final parser = buildParser();
  final input = text;
  final result = parser.parse(input);
  if (result.isSuccess)
    return result.value.toDouble();
  else
    return double.parse(text);
}