import 'package:flutter/material.dart';
import 'package:otp_integration/screens/registration_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 52),
            child: Column(
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
                  "Let's get Started",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text(
                  'Never a better time than now to start.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegistrationScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xFFd61b78),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
