import 'package:quotes_app/api/api_repository.dart';
import 'package:quotes_app/api/api_setting.dart';
import 'package:quotes_app/models/RandomImage.dart';

class RandomImageBackground {
  Future<dynamic> getRandomBacgroundImage(String category) async {
    var response =
        await ApiRepository(url: '${ApiSettings.randomImageUrl}$category')
            .get();
    if (response != null) {
      RandomBackgroundImage randomBackgroundImage =
          RandomBackgroundImage.fromJson(response);
      return randomBackgroundImage;
    } else
      return RandomBackgroundImage();
  }
}
