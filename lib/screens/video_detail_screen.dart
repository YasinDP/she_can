// import 'package:flutter/material.dart';
// import 'package:learn360/widgets/home/addon_course_card.dart';
// import 'package:learn360/widgets/related_video_card.dart';
// import 'package:learn360/widgets/upcoming_video_card.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoScreen extends StatefulWidget {
//   VideoScreen({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//   YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId: 'fRRCRVoMjWI', // id youtube video
//       flags: YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ));

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             YoutubePlayer(
//               controller: _controller,
//               showVideoProgressIndicator: true,
//               progressIndicatorColor: Colors.blueAccent,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Chapter: The title of the Chapter",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "Subject: SubName",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text("Course: Course name",
//                           style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(height: 1, width: width, color: Colors.grey),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Notes:",
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean porta ac lacus non iaculis. Phasellus a bibendum ipsum, a vestibulum orci. Sed nec condimentum urna, ut varius elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris et hendrerit nunc. Aliquam volutpat orci non tellus ullamcorper ullamcorper. Nunc placerat quam nec lacinia finibus."),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean porta ac lacus non iaculis. Phasellus a bibendum ipsum, a vestibulum orci. Sed nec condimentum urna, ut varius elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris et hendrerit nunc. Aliquam volutpat orci non tellus ullamcorper ullamcorper. Nunc placerat quam nec lacinia finibus."),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Upcoming Classes",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "View All",
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                       width: width,
//                       height: height / 4,
//                       child: UpcomingVideeCard()),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Related Classes",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "View All",
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                       width: width,
//                       height: height / 4,
//                       child: RelatedVideoCard()),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
