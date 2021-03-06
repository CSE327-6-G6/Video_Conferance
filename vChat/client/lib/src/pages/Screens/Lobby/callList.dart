import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vChat_v1/src/pages/bottom_navbar.dart';
import 'package:vChat_v1/src/pages/Screens/Lobby/addContacts_Dialogue.dart';
import 'package:vChat_v1/src/utils/firebase.dart';
import 'package:vChat_v1/src/pages/Screens/videoCall/call.dart';

class CallList extends StatefulWidget {
  CallList({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CallList createState() => _CallList();
}

class _CallList extends State<CallList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  PageController _pageController;
  int _page = 0;

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _pageController = PageController(initialPage: 0);
  }

  @override
  bool get wantKeepAlive => true;

  void navigationTapped(int page) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallList(),
        ));
  }

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration.collapsed(
            hintText: 'Search',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.view_agenda_rounded,
            ),
            onPressed: () async {
              SharedPreferences data = await SharedPreferences.getInstance();
              return showDialog(
                  context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Invite Code"),
                      content: Text(data.getString('invite')),
                    );
                  });
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.purple,
          labelColor: Colors.purple,
          unselectedLabelColor: Theme.of(context).textTheme.caption.color,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              text: "Call",
            ),
            Tab(
              text: "Groups",
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: getContacts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot);
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot contact = snapshot.data.docs[index];
                    return ListTile(
                      // Access the fields as defined in FireStore
                      title: Text(contact.data()['name']),
                      subtitle: Text(contact.data()['channelID']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.call,
                              size: 20.0,
                              color: Colors.purple,
                            ),
                            onPressed: () async {
                              await _handleCameraAndMic();
                              print(contact.data()["channelID"]);
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CallPage(
                                            channelName:
                                                contact.data()["channelID"],
                                            role: ClientRole.Broadcaster,
                                          )));
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }

            return Center(child: Text("loading"));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createAlertDialogue(context);
        },
        // child: Icon(Icons.add),
        child: Icon(Icons.add_circle_outline),
        backgroundColor: Colors.purple,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.white,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.purple,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.black),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Container(height: 0.0),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
