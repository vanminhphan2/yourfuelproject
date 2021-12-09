import 'package:your_fuel_app/provider/base_provider.dart';

class AppController with BaseProvider{

  LoadingProvider get loading => getProvider();

}

final appController = AppController();