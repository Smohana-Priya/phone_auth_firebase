// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common/common_button.dart';
import '../common/common_textfield.dart';
import '../common/overlay_container.dart';
import '../const/app_colors.dart';
import '../const/app_const.dart';
import '../service/auth_service.dart';
import 'home.dart';

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

  void nextStep() {
    setState(() {
      showSendOTPButton = false;
    });
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
                      text: AppConst.login,
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
                    onPressed: () {
                      AuthService.sentOtp(
                          mobileNo: _mobileNoCtrl.text,
                          nextStep: () => nextStep());
                    },
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
              onPressed: () {
                AuthService.verifyOTP(otp: _otpCtrl.text).then((value) {
                  if (value == "Success") {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }
                });
              },
              text: AppConst.Login,
              color: AppColors.buttonColor,
            ))
          ],
        ),
      ),
    );
  }
}
