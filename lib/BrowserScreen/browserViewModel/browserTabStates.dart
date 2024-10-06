import 'package:cinema/BrowserScreen/dataBrowser/responseBrowser/browserDiscoveryRespone.dart';
import 'package:cinema/BrowserScreen/dataBrowser/responseBrowser/browserResponse.dart';

abstract class BrowserTabStates {}

class BrowserTabInitialState extends BrowserTabStates {}

class BrowserTabLoadinglState extends BrowserTabStates {}

class BrowserTabErrorState extends BrowserTabStates {
  String errorMessage;
  BrowserTabErrorState({required this.errorMessage});
}

class BrowserTabSuccessState extends BrowserTabStates {
  BrowserResponse browserResponse;
  BrowserTabSuccessState({required this.browserResponse});
}

class BrowserDiscoveryTabLoadinglState extends BrowserTabStates {}

class BrowserDiscoveryTabErrorState extends BrowserTabStates {
  String errorMessage;
  BrowserDiscoveryTabErrorState({required this.errorMessage});
}

class BrowserDiscoveryTabSuccessState extends BrowserTabStates {
  BrowserDiscoveryResponse browserDiscoveryResponse;
  BrowserDiscoveryTabSuccessState({required this.browserDiscoveryResponse});
}

class movieDiscoveryTabLoadinglState extends BrowserTabStates {}

class movieDiscoveryTabErrorState extends BrowserTabStates {
  String errorMessage;
  movieDiscoveryTabErrorState({required this.errorMessage});
}

class movieDiscoveryTabSuccessState extends BrowserTabStates {
  BrowserDiscoveryResponse movieDiscoveryResponse;
  movieDiscoveryTabSuccessState({required this.movieDiscoveryResponse});
}
