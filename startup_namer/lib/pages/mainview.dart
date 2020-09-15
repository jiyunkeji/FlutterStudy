import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  _MainViewState createState() => _MainViewState();
}

class ListItem {
  String name;
  String path;

  ListItem(this.name, this.path);
}

class _MainViewState extends State<MainView> {
  final List<ListItem> entries = <ListItem>[ListItem("百度地图", "/baiDuMapView"),ListItem("日历", "/calendar")];

  @override
  void initState() {
    super.initState();
//    if(Theme.of(context).platform == TargetPlatform.iOS){
//
//      LocationFlutterPlugin.setApiKey("");
//    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, entries[index].path);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.orangeAccent,
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      '${entries[index].name}',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            );
          }),
    );
  }
}
