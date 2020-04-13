import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ThemeItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ThemeItem> _themeItems = ThemeItem.getThemeItems();

  List<DropdownMenuItem<ThemeItem>> _dropDownMenuItems;

  ThemeItem _selectedItem;

  List<DropdownMenuItem<ThemeItem>> buildDropdownMenuItems() {
    List<DropdownMenuItem<ThemeItem>> items = List();
    for (ThemeItem themeItem in _themeItems) {
      items
          .add(DropdownMenuItem(value: themeItem, child: Text(themeItem.name)));
    }
    return items;
  }

  void changeColor() {
    DynamicTheme.of(context).setThemeData(this._selectedItem.themeData);
  }

  setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dynTheme', _selectedItem.slug);
  }

  onChangeDropdownItem(ThemeItem selectedItem) {
    setState(() {
      this._selectedItem = selectedItem;
    });
    changeColor();
    setSharedPrefs();
  }

  @override
  void initState() {
    _dropDownMenuItems = buildDropdownMenuItems();
    _selectedItem = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themes demo"),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(Icons.palette, color: Colors.white),
            items: _dropDownMenuItems,
            onChanged: onChangeDropdownItem,
            underline: SizedBox(),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        child: ListView(padding: EdgeInsets.all(5), children: [
          Card(
            child: Column(
              children: <Widget>[
                Image.asset("assets/pc-setup.jpg"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Built a new PC setup in last 15 days",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: DynamicTheme.of(context).data.iconTheme.color,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                "CPU",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize:
                        DynamicTheme.of(context).data.textTheme.title.fontSize),
              ),
              leading: Text(
                "\$ 500",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize: DynamicTheme.of(context)
                        .data
                        .textTheme
                        .subtitle
                        .fontSize),
              ),
              trailing: Icon(
                Icons.thumb_up,
                color: DynamicTheme.of(context).data.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                "Speaker",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize:
                        DynamicTheme.of(context).data.textTheme.title.fontSize),
              ),
              leading: Text("\$ 100",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize: DynamicTheme.of(context)
                        .data
                        .textTheme
                        .subtitle
                        .fontSize),),
              trailing: Icon(
                Icons.thumb_down,
                color: DynamicTheme.of(context).data.iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                "Monitor",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize:
                        DynamicTheme.of(context).data.textTheme.title.fontSize),
              ),
              leading: Text("\$ 200",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize: DynamicTheme.of(context)
                        .data
                        .textTheme
                        .subtitle
                        .fontSize),),
              trailing: Icon(
                Icons.thumb_down,
                color: DynamicTheme.of(context).data.iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Text("\$ 50",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize: DynamicTheme.of(context)
                        .data
                        .textTheme
                        .subtitle
                        .fontSize),),
              title: Text(
                "Keyboard",
                style: TextStyle(
                    color: DynamicTheme.of(context).data.textTheme.title.color,
                    fontSize:
                        DynamicTheme.of(context).data.textTheme.title.fontSize),
              ),
              trailing: Icon(
                Icons.thumb_up,
                color: DynamicTheme.of(context).data.primaryColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
