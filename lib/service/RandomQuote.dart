import 'package:quotes_app/api/api_repository.dart';
import 'package:quotes_app/api/api_setting.dart';
import 'package:quotes_app/models/Quote.dart';

class RandomQuote {
  Future<dynamic> getRandomQuote() async {
    var response =
        await ApiRepository(url: '${ApiSettings.randomQuoteUrl}').get();
    if (response != null) {
      Quote quote = Quote.fromJson(response);
      return quote;
    } else
      return Quote();
  }
}
