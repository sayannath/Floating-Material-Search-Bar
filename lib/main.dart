import 'package:demo_search/widget/search_bar/floatingSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _isSearching;
  String _searchText = "";
  List searchResult = new List();

  _MyAppState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    _list = List();
    _list.add("Indian rupee");
    _list.add("United States dollar");
    _list.add("Australian dollar");
    _list.add("Euro");
    _list.add("British pound");
    _list.add("Yemeni rial");
    _list.add("Japanese yen");
    _list.add("Hong Kong dollar");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          // For Android.
          statusBarIconBrightness: Brightness
              .dark, // Use [light] for white status bar and [dark] for black status bar.
          // For iOS.
          statusBarBrightness: Brightness
              .light, // Use [dark] for white status bar and [light] for black status bar.
        ),
        child: Scaffold(
          key: globalKey,
          body: FloatingSearchBar(
              pinned: true,
              padding: EdgeInsets.only(top: 10.0),
              controller: _controller,
              drawer: Drawer(
                child: Container(),
              ),
              trailing: CircleAvatar(
                child: Text("S"),
              ),
              onChanged: searchOperation,
              decoration: InputDecoration.collapsed(
                  hintText: "Search...",
                  hintStyle: Theme.of(context).textTheme.subtitle1),
              children: [
                Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Flexible(
                          child: searchResult.length != 0 ||
                                  _controller.text.isNotEmpty
                              ? new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResult.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String listData = searchResult[index];
                                    return new ListTile(
                                      title: new Text(listData.toString()),
                                    );
                                  },
                                )
                              : new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String listData = _list[index];
                                    return new ListTile(
                                      title: new Text(listData.toString()),
                                    );
                                  },
                                ))
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(data);
        }
      }
    }
  }
}
