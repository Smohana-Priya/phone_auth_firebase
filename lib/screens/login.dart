// ignore_for_file: avoid_print

import 'package:ecbee_inovations/const/app_colors.dart';
import 'package:ecbee_inovations/const/app_const.dart';
import 'package:ecbee_inovations/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        context, MaterialPageRoute(builder: (context) => Dashboard()));
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
                    Container(
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
                            const Text(
                              AppConst.phoneNo,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              style: const TextStyle(color: Colors.white),
                              controller: _mobileNoCtrl,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.primaryColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                            const SizedBox(height: 40),
                            if (showSendOTPButton)
                              Center(
                                  child: SizedBox(
                                height: 65,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: sendOTP,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    AppConst.sendOtp,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              )),
                            if (!showSendOTPButton)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    AppConst.otp,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: _otpCtrl,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primaryColor,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 60,
                            ),
                            Center(
                                child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: verifyOTP,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color.fromRGBO(85, 85, 85, 1)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  AppConst.Login,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -15,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.38),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              AppConst.login,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
