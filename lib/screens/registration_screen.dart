import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_integration/screens/verification_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String verification_id = '';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var phone = '';

  @override
  void initState() {
    // TODO: implement initState
    countryCodeController.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
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
                      "Registration",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Text(
                        "Add your phone number we'll send you verification code so we know you are real.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      //height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 40,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        controller: countryCodeController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: phoneController,
                                      maxLength: 10,
                                      onChanged: (value) {
                                        phone = value;
                                        _formKey.currentState?.validate();
                                      },
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        print("va;ureeee ${value}");
                                        print("vureeee ${phone}");

                                        if (value!.isEmpty) {
                                          return 'Please Enter mobile number';
                                        } else if (!RegExp(
                                                r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                            .hasMatch(value)) {
                                          return "Please Enter a Valid Phone Number";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Mobile Number',
                                          labelStyle: TextStyle(
                                            color: Colors.grey.shade200,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             VerificationScreen()));
                                  }
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber:
                                        countryCodeController.text + phone,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      RegistrationScreen.verification_id =
                                          verificationId;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VerificationScreen()));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const VerificationScreen()
                                  // )
                                  // );
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
                                      'Send Code',
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
