import 'package:yourfuel/provider/base_provider.dart';

class AppController with BaseProvider{

  LoadingProvider get loading => getProvider();

}

final appController = AppController();