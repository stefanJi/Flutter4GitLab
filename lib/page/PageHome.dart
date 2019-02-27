import 'package:F4Lab/api.dart';
import 'package:F4Lab/const.dart';
import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/model/user.dart';
import 'package:F4Lab/page/tabs/activity.dart';
import 'package:F4Lab/page/tabs/groups.dart';
import 'package:F4Lab/page/tabs/project.dart';
import 'package:F4Lab/page/tabs/todo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const tabProjects = 0;
const tabActivity = 1;
const tabGroups = 2;
const tabTodo = 3;
const tabSetting = 4;
const tabAbout = 5;

const tabs = {
  tabProjects: "Projects",
  tabActivity: "Activity",
  tabGroups: "Groups",
  tabTodo: "Todo",
  tabSetting: "Config",
  tabAbout: "About"
};

class HomePage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> themeChanger;

  HomePage(this.isDark, this.themeChanger);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  User user;
  bool isLoading = false;
  int _currentTab = 0;
  String _barTitle;
  bool isDark;

  @override
  initState() {
    super.initState();
    _getStoreNav();
    _barTitle = tabs[_currentTab];
    _loadToken();
    isDark = widget.isDark;
  }

  _loadToken() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final token = sp.getString(KEY_ACCESS_TOKEN) ?? null;
    final host = sp.getString(KEY_HOST) ?? null;
    if (token == null || host == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    GitlabClient.setUpTokenAndHost(token, host);

    final user = await ApiService.getAuthUser();
    setState(() {
      isLoading = false;
      this.user = user;
    });
  }

  _navigateToConfig(BuildContext c) async {
    final success = await Navigator.pushNamed(context, '/config');
    if (success != null && success) {
      _loadToken();
    } else {
      print("cancel config");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : user == null
            ? Scaffold(
                appBar: AppBar(
                  title: Text(APP_NAME),
                ),
                body: Center(
                  child: FlatButton(
                    onPressed: () {
                      _navigateToConfig(context);
                    },
                    child: Text(
                      "Config Access_Token & Host 👉",
                    ),
                  ),
                ),
              )
            : Scaffold(
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
                          user.name,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        accountEmail: Text(
                          user.email,
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                      ),
                      ListTile(
                        selected: _currentTab == tabProjects,
                        leading: Icon(Icons.category),
                        title: Text(tabs[tabProjects]),
                        onTap: () => _switchTab(tabProjects),
                      ),
                      ListTile(
                        selected: _currentTab == tabActivity,
                        leading: Icon(Icons.local_activity),
                        title: Text(tabs[tabActivity]),
                        onTap: () => _switchTab(tabActivity),
                      ),
                      ListTile(
                        selected: _currentTab == tabTodo,
                        leading: Icon(Icons.view_list),
                        title: Text(tabs[tabTodo]),
                        onTap: () => _switchTab(tabTodo),
                      ),
                      ListTile(
                        selected: _currentTab == tabGroups,
                        leading: Icon(Icons.group),
                        title: Text(tabs[tabGroups]),
                        onTap: () => _switchTab(tabGroups),
                      ),
                      ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(tabs[tabSetting]),
                          onTap: () => Navigator.pushNamed(context, '/config')),
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
                                  value: isDark)
                            ],
                          ))
                    ],
                  ),
                ),
                body: Builder(builder: (context) {
                  return _getTab();
                }),
              );
  }

  _switchTab(int tabIndex) {
    Navigator.of(context).pop();
    setState(() {
      _currentTab = tabIndex;
      _barTitle = tabs[tabIndex];
    });
    _storeNav(tabIndex);
  }

  _getTab() {
    switch (_currentTab) {
      case tabActivity:
        return Activity();
      case tabProjects:
        return Project();
      case tabTodo:
        return Todo();
      case tabGroups:
        return Groups();
    }
  }

  _storeNav(int tabIndex) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(KEY_TAB_INDEX, tabIndex);
  }

  _getStoreNav() async {
    final index = await SharedPreferences.getInstance()
        .then((sp) => sp.getInt(KEY_TAB_INDEX) ?? tabProjects);
    if (mounted) {
      setState(() {
        _currentTab = index;
        _barTitle = tabs[index];
      });
    }
  }

  _changeTheme(bool newValue) {
    widget.themeChanger(newValue);
    setState(() {
      isDark = newValue;
    });
  }
}
