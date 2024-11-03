import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waveconnect/resources/auth_methods.dart';
import 'package:waveconnect/responsive/mobile_screen_layout.dart';
import 'package:waveconnect/responsive/responsive_layout_screen.dart';
import 'package:waveconnect/responsive/web_screen_layout.dart';
import 'package:waveconnect/screens/signup_screen.dart';
import 'package:waveconnect/utils/colors.dart';
import 'package:waveconnect/utils/utils.dart';
import 'package:waveconnect/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobilescreenlayout: MobileScreenLayout(),
            webscreenlayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //svg image
              SvgPicture.asset(
                'assets/RZegbm01.svg',
                color: primaryColor,
                height: 64,
              ),

              const SizedBox(height: 64),
              //text field input for email
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailcontroller,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for password
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordcontroller,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //login button
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Log in'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              //Transitioning to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
