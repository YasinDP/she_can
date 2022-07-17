import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:she_can/screens/Login/signup_screen.dart';
import 'package:she_can/screens/Login/update_password_screen.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
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
          "Login",
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
                "Enter your login details to access your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito-Regular',
                    fontSize: 24,
                    color: ColorsRes.introMessagecolor),
              )),
          const SizedBox(height: 35),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration:
                  DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
              child: Column(children: [
                Container(
                  height: 61,
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
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
                const Divider(
                  height: 0.0,
                  thickness: 2,
                ),
                Container(
                  height: 61,
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    style: const TextStyle(color: ColorsRes.black),
                    cursorColor: ColorsRes.black,
                    decoration: InputDecoration(
                      hintText: "PAssword",
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
                const Divider(
                  height: 0.0,
                  thickness: 2,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UpdatePasswordScreen()));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 61,
                        alignment: Alignment.centerRight,
                        child: const Text("Forgot Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorsRes.introMessagecolor))))
              ])),
          const SizedBox(height: 43),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Dashboard()));
              },
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
                          style:
                              TextStyle(color: ColorsRes.white, fontSize: 20),
                        ),
                        const SizedBox(width: 65),
                        Align(
                            alignment: Alignment.center,
                            child:
                                SvgPicture.asset("assets/images/continue.svg"))
                      ]))),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          Container(
              margin: const EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: const Text("Don't have Account ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, color: ColorsRes.introMessagecolor))),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()));
            },
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                child: const Text("Sign Up",
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
