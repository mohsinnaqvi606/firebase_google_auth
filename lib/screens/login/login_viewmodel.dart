import 'package:firebase_auth/firebase_auth.dart';
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


  loginButton2() async {
    GoogleSignIn _googleSignIn;
    GoogleSignInAccount? data;
    try {
      _googleSignIn = GoogleSignIn(
        scopes: [
          "https://www.googleapis.com/auth/userinfo.email",
          "https://www.googleapis.com/auth/userinfo.profile"
        ],
      );
      _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      print(googleUser?.displayName);

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );


      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Access the user information
      final User? user = userCredential.user;

      // You can now use the user information as needed
      print('Signed in as: ${user!.displayName}');
    } catch (e) {
      print(e.toString());
    }

  }
}
