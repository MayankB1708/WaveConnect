import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waveconnect/resources/auth_methods.dart';
import 'package:waveconnect/responsive/mobile_screen_layout.dart';
import 'package:waveconnect/responsive/responsive_layout_screen.dart';
import 'package:waveconnect/responsive/web_screen_layout.dart';
import 'package:waveconnect/screens/login_screen.dart';
import 'package:waveconnect/utils/colors.dart';
import 'package:waveconnect/utils/utils.dart';
import 'package:waveconnect/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}


class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signupuser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernamecontroller.text,
      bio: _biocontroller.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobilescreenlayout: MobileScreenLayout(),
          webscreenlayout: WebScreenLayout(),
        ),
      ),
    );
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
              //Circular widget for image
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png')),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectimage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),
              //textfield input for username
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernamecontroller,
              ),
              const SizedBox(
                height: 24,
              ),
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
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _biocontroller,
              ),
              const SizedBox(
                height: 24,
              ),
              //login button
              InkWell(
                onTap: signUpUser,
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
                      : const Text('Sign up'),
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
                    child: const Text("Have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Login",
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
