import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:she_can/helper/functions.dart';
import 'package:she_can/models/user.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/user.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/screens/login/login_screen.dart';
import 'package:she_can/screens/search_screen.dart';
import 'package:she_can/widgets/profile/update_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ScrollController? scrollController;
  late AuthNotifier authProvider;
  String? updatedName;
  String? updatedPassword;
  String? currentPassword;

  updateProfile() {
    User currentUser = authProvider.currentUser ?? UserProvider.currentUser!;
    if (currentPassword != currentUser.password) {
      showSnackBar(context,
          message: "The existing password you entered is incorrect");
    }
    if (currentUser.name != updatedName &&
        updatedName != null &&
        updatedName != "") {
      authProvider.updateName(updatedName!);
    }
    if (currentUser.password != updatedPassword &&
        updatedPassword != null &&
        updatedPassword != "") {
      authProvider.updatePassword(updatedPassword!);
    }
  }

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
  void didChangeDependencies() {
    authProvider = context.watch<AuthNotifier>();
    super.didChangeDependencies();
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
    User currentUser = authProvider.currentUser ?? UserProvider.currentUser!;
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
                      child: Text.rich(TextSpan(
                          text: "${currentUser.name}\n",
                          style: const TextStyle(
                              color: ColorsRes.white, fontSize: 24),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "${currentUser.username}\n",
                              style: const TextStyle(
                                  color: ColorsRes.white, fontSize: 16),
                            ),
                          ]))),
                ),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Provider.of<AuthNotifier>(context, listen: false)
                        .logoutUser();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName, (Route<dynamic> route) => false);
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
                        children: const [
                          Text(
                            "Logout",
                            style: TextStyle(
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
                        title: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorsRes.black,
                          ),
                        ),
                        dense: true,
                        leading: SvgPicture.asset(
                          'assets/images/profile_a.svg',
                          height: 25,
                        ),
                        onTap: _showEditProfileDialog,
                      ),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -1),
                        dense: true,
                        title: Text(
                          currentUser.isInstructor ? "My Courses" : "Courses",
                          style: const TextStyle(
                            fontSize: 18,
                            color: ColorsRes.black,
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/profile_b.svg',
                          height: 25,
                        ),
                        onTap: () => Navigator.of(context).pushNamed(
                            SearchScreen.routeName,
                            arguments: currentUser.isInstructor
                                ? currentUser.username
                                : null),
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
                        subtitle: const Text(
                          "miniproject977@gmail.com",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        leading: SvgPicture.asset(
                          'assets/images/profile_h.svg',
                          height: 25,
                        ),
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

  _showEditProfileDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: const Text(
          "Update Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsRes.appcolor,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: UpdateProfile(
          onNameChanged: (value) => updatedName = value,
          onPasswordChanged: (value) => updatedPassword = value,
          onCurrentPasswordChanged: (value) => currentPassword = value,
        ),
        actions: <Widget>[
          ElevatedButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
              child: const Text('ADD'),
              onPressed: () {
                updateProfile();
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
