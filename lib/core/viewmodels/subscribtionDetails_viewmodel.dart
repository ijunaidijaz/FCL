import 'package:fcl/core/datamodels/subscribtionDetail_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class SubscribtionDetailsViewModel extends BaseViewmodel {
  var subscribtionData;
  Future<SubscribtionDetailDatamodel> getSubscribtionData() async {
    String loginToken = await getLoginToken() ?? "";
    print("Token is $loginToken");
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (subscribtionData == null) {
      try {
        final response = await client.get(
          Uri.parse(kSubscribtionDetailApi),
          headers: _setHeaders(),
        );
        final _subscribtionData =
            subscribtionDetailDatamodelFromJson(response.body);

        return _subscribtionData;
      } catch (e) {
        print("Track::SubscribtionAPI error $e");
      }
    }
    return subscribtionData;
  }
}
