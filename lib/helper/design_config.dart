import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/models/course.dart';

class DesignConfig {
  static BoxDecoration boxDecorationContainer(Color color, double radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static Widget shadowButtonFullwidgth(Color btncolor, String btntext,
      Color textcolor, double radius, Color bordercolor, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      alignment: Alignment.center,
      decoration: buttonShadow(btncolor, radius, bordercolor),
      child: Text(
        btntext,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textcolor,
        ),
      ),
    );
  }

  static BoxDecoration buttonShadow(
      Color btncolor, double radius, Color bordercolor) {
    return BoxDecoration(
        color: btncolor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(color: bordercolor),
        boxShadow: [
          BoxShadow(
            color: btncolor.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ]);
  }

  static Widget displayCourseInstructor(Course item) {
    return Padding(
      // padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
      padding: const EdgeInsetsDirectional.only(start: 10, end: 5, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.category.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: ColorsRes.tabItemColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.instructor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          //Text("\t\t${item.rate}",style: TextStyle(color: ColorsRes.white,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }

  static Widget displayCourseTitle(String title, int line) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 5, top: 8),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: ColorsRes.introTitlecolor),
        maxLines: line,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static Widget displayCourseTitleMultiline(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 5, end: 5, top: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: ColorsRes.introTitlecolor),
        //style: TextStyle(color: ColorsRes.black,fontWeight: FontWeight.bold),
      ),
    );
  }

  static Widget displayImage(String image, double height, double width) {
    return OctoImage(
      image: CachedNetworkImageProvider(image),
      placeholderBuilder: OctoPlaceholder.blurHash(
        "L370Gpja0cj[xHayNYj[0dj[}^ay",
      ),
      width: width,
      height: height,
      errorBuilder: OctoError.icon(color: ColorsRes.black),
      fit: BoxFit.fill,
    );
  }
}
