import 'package:fcl/core/datamodels/socialLinks_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class SocialLinksViewModel extends BaseViewmodel {
  var socialLinksData;
  Future<SocialLinksDatamodel> getSocialLinksDataData() async {
    String loginToken = await getLoginToken() ?? "";
    print("Token is $loginToken");
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (socialLinksData == null) {
      try {
        final response = await client.get(
          Uri.parse(kSocialLinksApi),
          headers: _setHeaders(),
        );
        final _socialLinksData = socialLinksDatamodelFromJson(response.body);
        return _socialLinksData;
      } catch (e) {
        print("Track::SocialLinksAPI error $e");
      }
    }
    return socialLinksData;
  }
}
