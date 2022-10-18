import 'package:fcl/core/datamodels/notifications_datamodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class NotificationsViewModel extends BaseViewmodel {
  var notificationsData;
  Future<NotificationsDatamodel> getNotificationsData() async {
    String loginToken = await getLoginToken() ?? "";
    print("Token is $loginToken");
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (notificationsData == null) {
      try {
        final response = await client.get(
          Uri.parse(kNotificationsApi),
          headers: _setHeaders(),
        );
        final _notificationsData =
            notificationsDatamodelFromJson(response.body);

        return _notificationsData;
      } catch (e) {
        print("Track::NotificationAPI error $e");
      }
    }
    return notificationsData;
  }
}
