class ApiSettings {
  //https://api.quotable.io/random
  static const String _baseQuoteUrl = 'https://api.quotable.io/';
  static const String randomQuoteUrl = '${_baseQuoteUrl}random';

  //https://random.imagecdn.app/v1/image?category=buildings&format=json&width=1080&height=1920
  static const String _baseRandomImageUrl =
      'https://random.imagecdn.app/v1/image?format=json';
  static const String randomImageUrl = '${_baseRandomImageUrl}&category=';
}
