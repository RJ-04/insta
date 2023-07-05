import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/sign_up_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field.dart';

import '../responsive/mobile_screen_layout.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result == "success") {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, result);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreen
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3.5)
              : const EdgeInsets.all(25.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              /* app image */

              SvgPicture.asset(
                'assests/ic_instagram.svg',
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcATop),
                height: 115,
              ),
              const SizedBox(height: 70),

              /* textfield for email */

              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Email (Janedoe1900@gmail.com)",
                textInputType: TextInputType.emailAddress,
                autoCorrect: false,
                autoFill: const [AutofillHints.email],
              ),
              const SizedBox(height: 5),

              /* password */

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "password (#jane_200)",
                textInputType: TextInputType.text,
                autoCorrect: false,
                autoFill: null,
                isPass: true,
              ),
              const SizedBox(height: 30),

              /* login button */

              InkWell(
                splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                onTap: logInUser,
                splashColor: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                hoverColor: secondaryColor,
                onLongPress: () {
                  secondaryColor;
                },
                mouseCursor: MaterialStateMouseCursor.clickable,
                child: Container(
                  width: double.tryParse('300'),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation(secondaryColor),
                            strokeWidth: 3.5,
                            backgroundColor: Color.fromARGB(255, 0, 255, 8),
                            strokeCap: StrokeCap.round,
                          ),
                        )
                      : const Text(
                          "Log In",
                          selectionColor: mobileBackgroundColor,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(flex: 5, child: Container()),

              /* transition to sign up */

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have a account?",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "   Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
