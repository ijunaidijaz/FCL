import 'package:fcl/core/datamodels/currentUser_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class CurrentUserViewModel extends BaseViewmodel {
  var currentUserData;
  Future<CurrentUserDatamodel> getCurrentUserData() async {
    String loginToken = await getLoginToken() ;
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (currentUserData == null) {
      try {
        final response = await client.get(
          Uri.parse(kCurrentUserApi),
          headers: _setHeaders(),
        );
        currentUserData = currentUserDatamodelFromJson(response.body);
        return currentUserData;
      } catch (e) {
        print("Track::CurrentUserAPI error $e");
      }
    }
    return currentUserData;
  }
}
