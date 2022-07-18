import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:she_can/helper/colors_res.dart';

import 'package:she_can/models/onboarding_content.dart';
import 'package:she_can/screens/Login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SizedBox(height: 78),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              contents[i].title!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: ColorsRes.introTitlecolor,
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                              ),
                            )),
                        const SizedBox(height: 20),
                        Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              contents[i].discription!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18,
                                color: ColorsRes.introMessagecolor,
                              ),
                            )),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            if (currentIndex == contents.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            }
                            _controller!.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.bounceIn,
                            );
                          },
                          child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Container(
                                alignment: AlignmentDirectional.topCenter,
                                height: 48,
                                margin: const EdgeInsets.only(left: 20),
                                width: 176,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        ColorsRes.secondgradientcolor,
                                        ColorsRes.firstgradientcolor,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    currentIndex == contents.length - 1
                                        ? "Get Started"
                                        : "Next",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: ColorsRes.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              contents.length,
                              (index) => buildDot(index, context),
                            ),
                          ),
                        ),
                        Expanded(
                            child: SvgPicture.asset(
                          contents[i].image!,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            ColorsRes.secondgradientcolor,
            ColorsRes.firstgradientcolor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
