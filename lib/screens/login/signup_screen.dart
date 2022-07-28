import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/helper/functions.dart';
import 'package:she_can/providers/auth.dart';

import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/screens/login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _conobscureText = true;
  bool isInstructor = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);
  }

  _register() async {
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    String name = nameController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    final RegExp validCharacters = RegExp(r'^[a-zA-Z]+$');
    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      showSnackBar(context, message: "Please fill in all details");
      return;
    }
    if (!validCharacters.hasMatch(name)) {
      showSnackBar(context,
          message:
              "Special characters and numbers are not allowed in the name field");
      return;
    }
    if (await auth.isUsernameTaken(username)) {
      showSnackBar(context,
          message:
              "The username '$username' is already taken. Please enter another username");
      return;
    }
    await auth.registerUser(
      name: name,
      username: username,
      password: password,
      isInstructor: isInstructor,
    );
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.bgPage,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shadowColor: Colors.transparent,
        backgroundColor: ColorsRes.appcolor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: ColorsRes.appcolor,
        ),
        title: const Text(
          "SignUp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 25),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Text(
                "Start by entering your details below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito-Regular',
                  fontSize: 18,
                  color: ColorsRes.introMessagecolor,
                  fontWeight: FontWeight.w500,
                ),
              )),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration:
                DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
            child: Container(
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: nameController,
                style: const TextStyle(color: ColorsRes.black),
                cursorColor: ColorsRes.black,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  hintStyle: Theme.of(context).textTheme.subtitle2!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorsRes.introMessagecolor)),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration:
                DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
            child: Container(
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: usernameController,
                style: const TextStyle(color: ColorsRes.black),
                cursorColor: ColorsRes.black,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: Theme.of(context).textTheme.subtitle2!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorsRes.introMessagecolor)),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration:
                DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
            child: Container(
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: passwordController,
                obscureText: _conobscureText,
                obscuringCharacter: "*",
                style: const TextStyle(color: ColorsRes.black),
                cursorColor: ColorsRes.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  hintText: "Password",
                  hintStyle: Theme.of(context).textTheme.subtitle2!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorsRes.introMessagecolor)),
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _conobscureText = !_conobscureText;
                      });
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 10),
                        child: Text(
                          _conobscureText ? "SHOW" : "HIDE",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: ColorsRes.introMessagecolor,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration:
                DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
            child: Container(
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: CheckboxListTile(
                  value: isInstructor,
                  title: Text(
                    "Are you an instructor !?",
                    style: Theme.of(context).textTheme.subtitle2!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorsRes.introMessagecolor)),
                  ),
                  checkColor: Colors.white,
                  activeColor: ColorsRes.appcolor,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        isInstructor = value;
                      });
                    }
                  }),
            ),
          ),
          const SizedBox(height: 35),
          TextButton(
            onPressed: _register,
            child: Container(
              padding: const EdgeInsets.only(left: 65),
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              height: 65,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  ColorsRes.secondgradientcolor,
                  ColorsRes.firstgradientcolor,
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "CONTINUE",
                    style: TextStyle(color: ColorsRes.white, fontSize: 20),
                  ),
                  const SizedBox(width: 65),
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/images/continue.svg"))
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          Container(
              margin: const EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: const Text("Already have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, color: ColorsRes.introMessagecolor))),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                child: const Text("SIGN IN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorsRes.appcolor,
                    ))),
          )
        ],
      ),
    );
  }
}
