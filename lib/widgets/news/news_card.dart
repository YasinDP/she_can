import 'package:flutter/material.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/models/news.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: CircleAvatar(
                radius: 30,
                child: ClipOval(
                    child:
                        DesignConfig.displayImage(news.image, 100.0, 100.0))),
            title: Text(news.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorsRes.introTitlecolor,
                )),
            subtitle: Text(news.publishedAt.toString(),
                style: const TextStyle(
                    fontSize: 14, color: ColorsRes.lightgraycolor)),
            onTap: () => onTap(context, news),
          )),
    );
  }
}

void onTap(BuildContext context, News news) {
  showDialog(
      context: context,
      builder: (context) => ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Dialog(
              child: NewsDetails(news: news),
            ),
          ));
}

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    Key? key,
    required this.news,
  }) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.8,
      height: height * 0.5,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  width: width * 0.8,
                  height: height * 0.2,
                  child: Image.network(
                    news.image,
                    fit: BoxFit.cover,
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.5)),
                  child: Text(
                    news.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              news.content,
            ),
          ),
        ],
      )),
    );
  }
}
