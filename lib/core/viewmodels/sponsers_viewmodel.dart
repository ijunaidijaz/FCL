import 'package:fcl/core/datamodels/sponsers_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class SponsersViewModel extends BaseViewmodel {
  var sponsersData;
  Future<SponsersDatamodel> getSponsersData() async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (sponsersData == null) {
      try {
        final response = await client.get(
          Uri.parse(kSponsersApi),
          headers: _setHeaders(),
        );
        final sponsersData = sponsersDatamodelFromJson(response.body);

        return sponsersData;
      } catch (e) {
        print("Track::SponsersPI error $e");
      }
    }
    return sponsersData;
  }
}
