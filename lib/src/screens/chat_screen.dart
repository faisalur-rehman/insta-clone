import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({this.profileName, this.usersList});
  final profileName;
  final usersList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(profileName),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.view_list),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: "Search",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usersList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(usersList[index]["ProfilePic"]),
                        ),
                        title: Text(usersList[index]["ProfileName"]),
                        subtitle: Text(
                            '${usersList[index]["LastMsgContent"]} . ${usersList[index]["Timing"]}'),
                        trailing: Icon(Icons.camera_alt),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ));
  }
}

class ChatSearch extends SearchDelegate<String> {
  final usersList;
  ChatSearch({this.usersList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionsList = query.isEmpty
        ? usersList
        : usersList.where((p) => p.displayName.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: ((context, index) => ListTile(
            onTap: () {
              //   showResults(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => ChatDetailScreen(
              //               photoUrl: suggestionsList[index].photoUrl,
              //               name: suggestionsList[index].displayName,
              //               receiverUid: suggestionsList[index].uid,
              //             ))));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(suggestionsList[index].photoUrl),
            ),
            title: Text(suggestionsList[index].displayName),
          )),
    );
  }
}
