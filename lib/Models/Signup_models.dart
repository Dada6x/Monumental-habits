import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monumental_habits/main.dart';

class SignupModels {
  static Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print("token returned :${googleAuth?.idToken}");
    await FirebaseAuth.instance.signInWithCredential(credential);

    final response =
        await Dio().post("http://10.0.2.2:8000/api/auth/google", data: {
      "id_token": googleAuth?.idToken,
    });
    if (response.data["status"]) {
      token!.setString("token", response.data["token"]);
    }
  }
}
