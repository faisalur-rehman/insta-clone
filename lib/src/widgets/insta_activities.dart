import 'package:flutter/material.dart';
import 'package:instagram_clone/src/customIcons/custom_icons.dart';
import 'package:instagram_clone/src/screens/chat_screen.dart';
import 'package:instagram_clone/src/widgets/post.dart';
import 'package:instagram_clone/src/widgets/story.dart';

class InstaActivities extends StatefulWidget {
  final response;
  InstaActivities(this.response) {
    if (response["Feed"][0]["Name"] != null) response["Feed"].insert(0, {});
  }

  @override
  _InstaActivitiesState createState() => _InstaActivitiesState();
}

class _InstaActivitiesState extends State<InstaActivities> {
  // Build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading(),
        title: title(),
        titleSpacing: 8.0, // Spacing for title
        actions: actions(),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: widget.response["Feed"].length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Story(
                storyResponse: widget.response["Stories"],
                profilURL: widget.response["AccountInfos"]["Picture"],
              ); // story.dart from widgets package
            } else {
              return Post(widget.response["Feed"]
                  [index]); // post.dart from widgets package
            }
          },
        ),
        onRefresh: () async {},
      ),
    );
  }

  // Leading widget in app bar i.e, camera icon in this application
  Widget leading() => IconButton(
        icon: Icon(
          CustomIcons.photo_camera,
          size: 32.0,
          color: Colors.black,
        ),
        onPressed: () {},
      );

  // Title of the app bar i.e, Instagram in this application
  Widget title() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32.0,
          ),
        ),
      );

  // Widgets in the right side of the applications i.e, igtv and send icon in this application
  List<Widget> actions() => <Widget>[
        // First item
        Stack(
          children: <Widget>[
            // IGTV button
            IconButton(
              // icon: SvgPicture.asset(
              //   UIImageData.igtv,
              //   color: Colors.black,
              // ),
              icon: Icon(
                CustomIcons.igtv,
                size: 28.0,
                color: Colors.black,
              ),
              onPressed: () {},
            ),

            // Red dot notification
            Positioned(
              top: 15.0, //15
              right: 9.0, //9.0
              child: Container(
                height: 10.0,
                width: 10.0,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),

        // Second item
        // SEND button
        Transform.rotate(
          angle: 0.2, //0.4
          child: IconButton(
            icon: Icon(
              CustomIcons.paper_plane,
              size: 28.0,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          profileName: widget.response["AccountInfos"]["Name"],
                          usersList: widget.response["DMs"])));
            },
          ),
        ),

        // For padding
        SizedBox(width: 12.0),
      ];
}
