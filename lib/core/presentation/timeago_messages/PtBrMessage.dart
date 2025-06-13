import 'package:timeago/timeago.dart';

class PtBrMessage implements LookupMessages {
  @override
  String prefixAgo() => 'há';

  @override
  String prefixFromNow() => 'em';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'alguns segundos';

  @override
  String aboutAMinute(int minutes) => '1 min';

  @override
  String minutes(int minutes) => '${minutes} min';

  @override
  String aboutAnHour(int minutes) => '1h';

  @override
  String hours(int hours) => '${hours}h';

  @override
  String aDay(int hours) => '1d';

  @override
  String days(int days) => '${days}d';

  @override
  String aboutAMonth(int days) => '1 mês';

  @override
  String months(int months) => '${months} meses';

  @override
  String aboutAYear(int year) => '1 ano';

  @override
  String years(int years) => '${years} anos';

  @override
  String wordSeparator() => ' ';
}
