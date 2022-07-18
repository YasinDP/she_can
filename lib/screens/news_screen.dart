import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/helper/functions.dart';
import 'package:she_can/models/news.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/news.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/sliver_appbar_delegate.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:she_can/widgets/news/add_news.dart';
import 'package:she_can/widgets/news/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewsScreenState();
  }
}

class NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late NewsNotifier newsProvider;

  ScrollController? scrollController;
  int currentSelected = 0, lesson = 1, id = 0, idvideo = 0;
  // FlickManager flickManager;
  bool descTextShowFlag = false;
  TabController? _controller;
  int _selectedIndex = 0;
  PlatformFile? pickedFile;
  String? title;
  String? content;

  Future<void> createNews() async {
    final newsProvider = Provider.of<NewsNotifier>(context, listen: false);

    if (title == null || title == "" || content == null || content == "") {
      return;
    } else {
      String image = await uploadFile();
      newsProvider.addNews(
        image: image,
        title: title!,
        content: content!,
      );
    }
  }

  Future<String> uploadFile() async {
    final path = 'news/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    late UploadTask uploadTask;

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => null);

    final urlDownload = await snapshot.ref.getDownloadURL();
    print("=========> urlDownload is $urlDownload");
    return urlDownload;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() => setState(() {}));

    _controller = TabController(length: 2, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      setState(() {});
    });

    // flickManager = FlickManager(
    //   videoPlayerController: VideoPlayerController.network(LessonsList[id].LessonsContaint[idvideo].lessonsContanUrl),
    // );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeDependencies() {
    newsProvider = Provider.of<NewsNotifier>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // flickManager.dispose();
    super.dispose();
  }

  Widget allNews() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 60),
      child: StreamBuilder<List<News>>(
          stream: newsProvider.getAllNews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<News> news = snapshot.data!;
              return ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: news.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsCard(news: news[index]);
                  });
            } else {
              return Container(
                width: width,
                height: height * 0.6,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: const Center(
                  child: Text("No news are available to read yet!"),
                ),
              );
            }
          }),
    );
  }

  Widget myNews() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 60),
      child: StreamBuilder<List<News?>>(
          stream: newsProvider.getMyNews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<News> news = snapshot.data!.whereType<News>().toList();
              return ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: news.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        key: Key(news[index].id),
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerRight,
                          decoration: DesignConfig.boxDecorationContainer(
                              ColorsRes.red, 10),
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this item?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("DELETE")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          // setState(() {
                          //   news.removeAt(index);
                          // });
                          newsProvider.deleteNews(id: news[index].id);
                          // Then show a snackbar.
                          showSnackBar(context, message: "News Deleted");
                        },
                        child: NewsCard(news: news[index]));
                  });
            } else {
              return Container(
                width: width,
                height: height * 0.6,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: const Center(
                  child: Text(
                    "You havent added any news of your own yet. Pls sign in as an Instructor to add news!",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget newsMenu() {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              shadowColor: Colors.transparent,
              snap: false,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text("",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: SvgPicture.asset(
                    "assets/images/topback.svg",
                    height: MediaQuery.of(context).size.width,
                    // fit: BoxFit.cover,
                  ) //Images.network
                  ),
              expandedHeight: 0,
              backgroundColor: ColorsRes.bgcolor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorsRes.appcolor),
                tooltip: 'Back',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ),
                  );
                },
              ), //IconButton
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: ColorsRes.appcolor,
                    indicatorWeight: 2,
                    controller: _controller,
                    labelColor: ColorsRes.appcolor,
                    unselectedLabelColor: ColorsRes.tabItemColor,
                    tabs: const [
                      Tab(
                        child: Text("ALL NEWS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                      Tab(
                        child: Text("MY NEWS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ],
                  ),
                )),
          ];
        },
        body: WillPopScope(
          onWillPop: () {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            ) as Future<bool>;
          },
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              allNews(),
              myNews(),
            ],
          ),
        ),
      ), //<Widget>[]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.bgPage,
      resizeToAvoidBottomInset: false,
      body: newsMenu(),
      floatingActionButton:
          !Provider.of<AuthNotifier>(context).currentUser!.isInstructor
              ? null
              : Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: FloatingActionButton(
                    onPressed: _showDialog,
                    backgroundColor: ColorsRes.appcolor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: const Text(
          "Add News",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsRes.appcolor,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: AddNews(
          onFilePick: (platformFile) =>
              setState(() => pickedFile = platformFile),
          onTitleChanged: (value) => title = value,
          onContentChanged: (value) => content = value,
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
                createNews();
                setState(() {
                  pickedFile = null;
                });
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
