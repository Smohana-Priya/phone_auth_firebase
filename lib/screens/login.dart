// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:ecbee_inovations/common/common_button.dart';
import 'package:ecbee_inovations/common/overlay_container.dart';
import 'package:ecbee_inovations/const/app_colors.dart';
import 'package:ecbee_inovations/const/app_const.dart';
import 'package:ecbee_inovations/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common/common_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSendOTPButton = true;
  final TextEditingController _mobileNoCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? _verificationId;

  void sendOTP() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${_mobileNoCtrl.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print("code verified------");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("verify failed-----");
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        print(
            "code sended---------$verificationId and resend token-------$resendToken");
        setState(() {
          _verificationId = verificationId;
          showSendOTPButton = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: _otpCtrl.text);

    await auth.signInWithCredential(credential);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.13,
              ),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildMainContainer(),
                    const OverlayContaier(
                      text: AppConst.Login,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildMainContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonTextField(
              controller: _mobileNoCtrl,
              label: AppConst.phoneNo,
            ),
            const SizedBox(height: 40),
            showSendOTPButton
                ? Center(
                    child: CommonButton(
                    onPressed: sendOTP,
                    text: AppConst.sendOtp,
                    color: AppColors.primaryColor,
                  ))
                : CommonTextField(
                    controller: _otpCtrl,
                    label: AppConst.otp,
                  ),
            const SizedBox(
              height: 60,
            ),
            Center(
                child: CommonButton(
              onPressed: verifyOTP,
              text: AppConst.Login,
              color: AppColors.buttonColor,
            ))
          ],
        ),
      ),
    );
  }
}
