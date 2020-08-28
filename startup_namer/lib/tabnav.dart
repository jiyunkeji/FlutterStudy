import 'package:flutter/material.dart';

class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text('Tabbed AppBar'),
            // bottom: new TabBar(
            //   isScrollable: true,
            //   tabs: choices.map((Choice choice) {
            //     return new Tab(
            //       text: choice.title,
            //       icon: new Icon(choice.icon),
            //     );
            //   }).toList(),
            // ),
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Row(
      children: [
        Container(
            width: 100,
            child: ListView(
              children: [
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  height: 50,
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
              ],
            )),
        Expanded(
            flex: 1,
            child: Container(
                width: 800,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(0),
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution is coming...'),
                      color: Colors.teal[500],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution, they...'),
                      color: Colors.teal[600],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution is coming...'),
                      color: Colors.teal[500],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution, they...'),
                      color: Colors.teal[600],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution is coming...'),
                      color: Colors.teal[500],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution, they...'),
                      color: Colors.teal[600],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution is coming...'),
                      color: Colors.teal[500],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Revolution, they...'),
                      color: Colors.teal[600],
                    ),
                    Container(
                      height: 50,
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      height: 50,
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      height: 50,
                      child: const Text('40 scream'),
                      color: Colors.teal[400],
                    ),
                  ],
                ))),
      ],
    );
  }
}

void main() {
  runApp(new TabbedAppBarSample());
}
