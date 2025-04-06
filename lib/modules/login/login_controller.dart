import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movieshub/config/config.dart';

import '../../utils/widgets/disclaimer_dialog.dart';

class LoginController extends BaseController {

  final Connectivity _connectivity = Connectivity();
  var connection = true.obs;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final validEmail = false.obs;

  final email = ''.obs;
  final pass = ''.obs;

  var tncUrl = 'https://niconil.app/terms-and-conditions/';
  var privacyUrl = 'https://niconil.app/privacy-policy/';
  var disclaimer = 'https://niconil.app/terms-and-conditions/';


  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  void setUserLogin(){
    appPref.isUserLogin = true;
  }


  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    connection.value = connectivityResult != ConnectivityResult.none;
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (connection.value) {
    } else {}
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.isNotEmpty) {
      connection.value = connectivityResults.first != ConnectivityResult.none;
    } else {
      connection.value = false;
    }
  }

  bool validateEmail(String? value) {
    // final bool emailValid =
    //     RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.{}!@#$]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //         .hasMatch(value!);
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value!);

    return emailValid;
  }


  void showDisclaimerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => DisclaimerDialog(
            imageUrl: Assets.images.disclaimer.path,
            title: 'Disclaimer',
            subtitle:
            disclaimer,
            buttonText: 'Close',
            onButtonPressed: () {
              Get.back();
            }));
  }



}
