import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ScrollController? scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() => setState(() {}));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin =
        MediaQuery.of(context).size.height * .24 - 4.0;
    //pixels from top where scaling should start
    const double scaleStart = 96.0;
    //pixels from top where scaling should end
    const double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController!.hasClients) {
      double offset = scrollController!.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      left: 5,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.bottomLeft,
          child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 104.0,
              height: 104.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
              ),
              child: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                      child: Image.asset(
                    "assets/images/avatar.png",
                    fit: BoxFit.cover,
                  )))),
        ),
      ),
    );
  }

  Widget profileMenu() {
    return Stack(children: <Widget>[
      CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            shadowColor: Colors.transparent,
            snap: false,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                "",
                style:
                    TextStyle(color: ColorsRes.introTitlecolor, fontSize: 28),
              ), //Text
              background: Stack(children: [
                Container(
                  color: ColorsRes.bgcolor,
                  height: MediaQuery.of(context).size.width,
                  child: SizedBox(
                      child: SvgPicture.asset(
                    'assets/images/topback.svg',
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .20,
                      left: MediaQuery.of(context).size.height * .18),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      margin: const EdgeInsets.only(left: 18, right: 20),
                      child: const Text.rich(TextSpan(
                          text: "Madonna Sebastian\n",
                          style:
                              TextStyle(color: ColorsRes.white, fontSize: 24),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "madonna_seb\n",
                              style: TextStyle(
                                  color: ColorsRes.white, fontSize: 16),
                            ),
                          ]))),
                ),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LetsGetStartActivity()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.center,
                    height: 40,
                    width: 78,
                    decoration: BoxDecoration(
                      color: ColorsRes.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Logout",
                            style: const TextStyle(
                                color: ColorsRes.introTitlecolor, fontSize: 16),
                          ),
                        ]),
                  )), //IconButton//IconButton
            ], //FlexibleSpaceBar
            expandedHeight: MediaQuery.of(context).size.height * .3,
            backgroundColor: ColorsRes.bgcolor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: ColorsRes.white),
              tooltip: 'Back',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
            ), //IconButton
          ), //SliverAppBar
          SliverList(
              delegate: SliverChildListDelegate([
            Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    decoration: DesignConfig.boxDecorationContainer(
                        ColorsRes.white, 10),
                    child: Column(children: <Widget>[
                      const SizedBox(height: 20),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 1, vertical: -1),
                        title: Text(
                          "Edit Profile",
                          style: const TextStyle(
                            fontSize: 18,
                            color: ColorsRes.black,
                          ),
                        ),
                        dense: true,
                        leading: SvgPicture.asset(
                          'assets/images/profile_a.svg',
                          height: 25,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -1),
                        dense: true,
                        title: const Text(
                          "My Courses",
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorsRes.black,
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/profile_b.svg',
                          height: 25,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -1),
                        dense: true,
                        title: const Text(
                          "Contact Us",
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorsRes.black,
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/profile_h.svg',
                          height: 25,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                    ]))),
          ]) //SliverChildBuildDelegate
              ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 90))
        ], //<Widget>[]
      ),
      _buildFab(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            )) as Future<bool>;
      },
      child: Scaffold(
        backgroundColor: ColorsRes.bgPage,
        resizeToAvoidBottomInset: false,
        body: profileMenu(),
      ),
    );
  }
}
