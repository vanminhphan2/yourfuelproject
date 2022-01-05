import 'package:flutter/cupertino.dart';
import 'package:yourfuel/provider/base_provider.dart';
import 'package:yourfuel/controller/dialog.dart';
import 'package:yourfuel/utils/app_utils.dart';

class AppController with BaseProvider{

  LoadingProvider get loading => getProvider();


  final dialog = DialogController(AppConstants.currentState.overlay!.context);

}

final appController = AppController();