import 'package:fcl/core/datamodels/liveScore_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class LiveScoreViewModel extends BaseViewmodel {
  var liveScoreData;
  Future<String> getLiveScoreData() async {
    String loginToken = await getLoginToken() ?? "";

    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (liveScoreData == null) {
      try {
        final response = await client.get(
          Uri.parse(kLiveScoreApi),
          headers: _setHeaders(),
        );
        final _liveScoreData = liveScoreDatamodelFromJson(response.body);
        print(
            "==Here Live Score URL ==  ${_liveScoreData.data.url}   ===============");
        return _liveScoreData.data.url;
      } catch (e) {
        print("Track::liveScoreApi error $e");
      }
    }
    return liveScoreData;
  }
}
