import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/routes.dart';

import '../../../routes/messenger.dart';
import '../../../service/error.dart';

class InternetProvider{
  void tryAgain({required var screen}) async{
    bool network = await checking();
    if (network) {
      Routes.pushreplace(screen: screen);
    } else {
      Messenger.pop(msg: "No Internet", color: redColor);
    }
  }
}