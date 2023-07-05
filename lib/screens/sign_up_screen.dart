import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:instagram_flutter/widgets/text_field.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    _image ??= (await NetworkAssetBundle(Uri.parse(
                'https://tse1.mm.bing.net/th?id=OIP.fpHfhXiopsHerHiZdhKIDAAAAA&pid=Api&P=0'))
            .load(
                'https://tse1.mm.bing.net/th?id=OIP.fpHfhXiopsHerHiZdhKIDAAAAA&pid=Api&P=0'))
        .buffer
        .asUint8List();

    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
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

  void navigateLogIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LogIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreen
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3.5)
              : const EdgeInsets.all(8.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 5, child: Container()),

              /* app image */

              SvgPicture.asset(
                'assests/ic_instagram.svg',
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcATop),
                height: 85,
              ),
              const SizedBox(height: 1),
              Flexible(flex: 2, child: Container()),

              /* circular widget to accept and show our selected file */

              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://tse1.mm.bing.net/th?id=OIP.fpHfhXiopsHerHiZdhKIDAAAAA&pid=Api&P=0'),
                        ),
                  Positioned(
                    bottom: -7,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              Flexible(flex: 5, child: Container()),

              /* textfield for email */

              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Email (Janedoe1900@gmail.com)",
                textInputType: TextInputType.emailAddress,
                autoCorrect: false,
                autoFill: const [AutofillHints.email],
              ),
              const SizedBox(height: 2),
              Flexible(flex: 1, child: Container()),

              /* textfield for password */

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "password (#jane_200)",
                textInputType: TextInputType.text,
                autoCorrect: false,
                autoFill: null,
                isPass: true,
              ),
              const SizedBox(height: 2),
              Flexible(flex: 1, child: Container()),

              /* textfield for username */

              TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Username (JD_69)",
                textInputType: TextInputType.text,
                autoCorrect: true,
                autoFill: const [AutofillHints.name],
              ),
              const SizedBox(height: 2),
              Flexible(flex: 1, child: Container()),

              /* textfield for bio */

              TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
                autoCorrect: true,
              ),
              const SizedBox(height: 3),
              Flexible(flex: 3, child: Container()),

              /* login button */

              InkWell(
                onTap: signUpUser,
                splashColor: secondaryColor,
                splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                hoverColor: secondaryColor,
                onLongPress: () {
                  secondaryColor;
                },
                mouseCursor: MaterialStateMouseCursor.clickable,
                child: Container(
                  width: double.tryParse('325'),
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
                      : const Text("Create Account"),
                ),
              ),
              Flexible(flex: 5, child: Container()),

              /* transition to sign up */

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have a account?\t\t",
                    style: TextStyle(fontStyle: FontStyle.normal),
                  ),
                  GestureDetector(
                    onTap: navigateLogIn,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
