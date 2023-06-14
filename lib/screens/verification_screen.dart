import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_integration/screens/registration_screen.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 50,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFFd61b78)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
      ),
    );
    var code = '';

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14, top: 18),
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      width: 240,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    "Verification",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      "Enter your OTP code number",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Pinput(
                            submittedPinTheme: submittedPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            length: 6,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onChanged: (value) {
                              code = value;
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          InkWell(
                              onTap: () async {
                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: RegistrationScreen
                                              .verification_id,
                                          smsCode: code);

                                  // Sign the user in (or link) with the credential
                                  await auth.signInWithCredential(credential);
                                  var snackBar = SnackBar(
                                      content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('Phone Number Verified'),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    ],
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const HomeScreen())
                                  // );
                                } catch (e) {
                                  var snackBar = SnackBar(
                                      content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Wrong OTP',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )
                                    ],
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  print(
                                    'Wrong otp',
                                  );
                                }
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFd61b78),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Didn't receive any code?",
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Resend New Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFFd61b78),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
