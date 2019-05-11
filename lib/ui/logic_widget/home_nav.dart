import 'package:F4Lab/const.dart';
import 'package:F4Lab/model/user.dart';
import 'package:F4Lab/ui/tabs/activity.dart';
import 'package:F4Lab/ui/tabs/groups.dart';
import 'package:F4Lab/ui/tabs/project.dart';
import 'package:F4Lab/ui/tabs/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeNav extends StatefulWidget {
  final User user;
  final ValueChanged<bool> themeChanger;
  final ValueChanged<bool> tokenChanger;
  final bool isDark;

  const HomeNav(this.user, this.tokenChanger, this.themeChanger, this.isDark);

  @override
  State<StatefulWidget> createState() => _State();
}

const _tabProjects = 0;
const _tabActivity = 1;
const _tabGroups = 2;
const _tabTodo = 3;
const _tabSetting = 4;
const _tabAbout = 5;

const _tabTitles = {
  _tabProjects: "Projects",
  _tabActivity: "Activity",
  _tabGroups: "Groups",
  _tabTodo: "Todo",
  _tabSetting: "Config",
  _tabAbout: "About"
};

class _State extends State<HomeNav> {
  int _currentTab = 0;
  String _barTitle;
  bool _isDark;
  List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _getStoreNav();
    _barTitle = _tabTitles[_currentTab];
    _isDark = widget.isDark;
    _tabs = List();
    _tabs.add(TabProject());
    _tabs.add(TabActivity());
    _tabs.add(TabGroups());
    _tabs.add(TabTodo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$_barTitle"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              accountName: Text(
                widget.user.name,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              accountEmail: Text(
                widget.user.email,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.user.avatarUrl),
              ),
            ),
            _buildNavItem(_tabProjects, Icons.category),
            _buildNavItem(_tabActivity, Icons.local_activity),
            _buildNavItem(_tabTodo, Icons.view_list),
            _buildNavItem(_tabGroups, Icons.group),
            _buildNavItem(_tabSetting, Icons.settings),
            AboutListTile(
              icon: Icon(Icons.apps),
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationLegalese: APP_LEGEND,
              applicationIcon: Image.network(
                APP_ICON_URL,
                width: 60,
                height: 60,
              ),
              aboutBoxChildren: <Widget>[
                OutlineButton(
                  child: Text("FeedBack"),
                  onPressed: () => launch(APP_FEED_BACK_URL),
                ),
                OutlineButton(
                  child: Text("See in GitHub"),
                  onPressed: () => launch(APP_REPO_URL),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Text("Dark Theme"),
                    Switch(
                        onChanged: (newValue) {
                          _changeTheme(newValue);
                        },
                        value: _isDark)
                  ],
                ))
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return IndexedStack(index: _currentTab, children: _tabs);
      }),
    );
  }

  ListTile _buildNavItem(int currentTab, IconData icon) {
    return ListTile(
      selected: _currentTab == currentTab,
      leading: Icon(icon),
      title: Text(_tabTitles[currentTab]),
      onTap: () => _switchTab(currentTab),
    );
  }

  _changeTheme(bool newValue) {
    widget.themeChanger(newValue);
    setState(() {
      _isDark = newValue;
    });
  }

  _switchTab(int tabIndex) {
    if (tabIndex == _tabSetting) {
      _navigateToConfig(context);
      return;
    }
    Navigator.of(context).pop();
    setState(() {
      _currentTab = tabIndex;
      _barTitle = _tabTitles[tabIndex];
    });
    _storeNav(tabIndex);
  }

  _navigateToConfig(BuildContext c) async {
    final success = await Navigator.pushNamed(context, '/config');
    print(success);
    if (success != null) {
      widget.tokenChanger(true);
    } else {
      print("cancel config");
    }
  }

  _storeNav(int tabIndex) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(KEY_TAB_INDEX, tabIndex);
  }

  _getStoreNav() async {
    final index = await SharedPreferences.getInstance()
        .then((sp) => sp.getInt(KEY_TAB_INDEX) ?? _tabProjects);
    if (mounted) {
      setState(() {
        _currentTab = index;
        _barTitle = _tabTitles[index];
      });
    }
  }
}
