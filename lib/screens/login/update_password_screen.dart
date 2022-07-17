import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';

import 'package:she_can/screens/Login/login_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UpdatePasswordScreenState();
  }
}

class UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _conobscureText = true;
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
        iconTheme: const IconThemeData(
          color: ColorsRes.appcolor,
        ),
        title: Text(
          "Create Password",
          style:
              const TextStyle(color: ColorsRes.introTitlecolor, fontSize: 28),
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
              child: Text(
                "Enter your login details to access your account",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Nunito-Regular',
                    fontSize: 24,
                    color: ColorsRes.introMessagecolor),
              )),
          const SizedBox(height: 35),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration:
                DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
            child: Container(
              height: 61,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
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
          const SizedBox(height: 69),
          TextButton(
              onPressed: () {},
              child: Text(
                "Already have an account?",
                style: const TextStyle(
                    color: ColorsRes.introMessagecolor, fontSize: 20),
              )),
          const SizedBox(height: 12),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: Text(
                "SIGN IN",
                style: const TextStyle(color: ColorsRes.appcolor, fontSize: 20),
              )),
          const SizedBox(height: 43),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
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
                        Text(
                          "CONTINUE",
                          style: const TextStyle(
                              color: ColorsRes.white, fontSize: 20),
                        ),
                        const SizedBox(width: 65),
                        Align(
                            alignment: Alignment.center,
                            child:
                                SvgPicture.asset("assets/images/continue.svg"))
                      ]))),
        ],
      ),
    );
  }
}
