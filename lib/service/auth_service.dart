// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

import '../const/app_const.dart';

class AuthService {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static String verifyId = "";

  static Future sentOtp({
    required String mobileNo,
    required Function nextStep,
  }) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91$mobileNo',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == AppConst.invalidPhoneNo) {
          print(AppConst.invalidNo);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future verifyOTP({required String otp}) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        return "Success";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  static Future logout() async {
    await firebaseAuth.signOut();
  }

  static Future<bool> isLoggedIn() async {
    var user = firebaseAuth.currentUser;
    return user != null;
  }
}
