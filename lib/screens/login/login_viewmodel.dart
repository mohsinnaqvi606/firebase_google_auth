import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends GetxController {
  RxString response = ''.obs;

  loginButton() async {
    GoogleSignIn googleAuth;
    GoogleSignInAccount? data;

    try {
      googleAuth = GoogleSignIn(
        scopes: [
          "https://www.googleapis.com/auth/userinfo.email",
          "https://www.googleapis.com/auth/userinfo.profile"
        ],
      );
      data = await googleAuth.signIn();
      googleAuth.signOut();

      if (data == null) {
        print('Something went wrong');
        return;
      } else {
        Map<String, dynamic> params = {
          'name': data.displayName,
          'email': data.email,
          'id': data.id,
        };
        response.value = params.toString();
        print(params);
      }
    } catch (e) {
      print(e);
    }
  }
}
