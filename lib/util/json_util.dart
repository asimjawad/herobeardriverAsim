// a class to take care of server side madness
class JsonUtil {
  static double parseDouble(dynamic input) => double.parse(input.toString());

  static int parseInt(dynamic input) => int.parse(input.toString());

  static int? tryParseInt(dynamic input) => int.tryParse(input.toString());

  static double? tryParseDouble(dynamic input) =>
      double.tryParse(input.toString());

  static String forceString(dynamic input) => input.toString();

  JsonUtil._();
}
