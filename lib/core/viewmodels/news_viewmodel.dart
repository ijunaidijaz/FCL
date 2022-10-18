import 'package:fcl/core/datamodels/news_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class NewsViewModel extends BaseViewmodel {
  var newsData;
  var currentUserData;
  Future<NewsDatamodel> getNewsData() async {
    print("========data is ++++++++++++++++======");

    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (newsData == null) {
      try {
        final response = await client.get(
          Uri.parse(kNewsApi),
          headers: _setHeaders(),
        );
        final _newsData = newsDatamodelFromJson(response.body);

        return _newsData;
      } catch (e) {
        print("Track::NewsAPI error $e");
      }
    }
    return newsData;
  }
}
