import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gitlab/const.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:flutter_gitlab/page/tabs/activity.dart';
import 'package:flutter_gitlab/page/tabs/project.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  dynamic user;
  bool isLoading = false;
  int _currentTab = 0;
  String _barTitle;

  @override
  initState() {
    super.initState();
    _getStoreNav();
    _barTitle = tabs[_currentTab];
    _loadToken();
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
    final client = GitlabClient();
    final resp = await client.get('user').whenComplete(client.close);
    if (resp.statusCode != 200) {
      user = null;
    }
    setState(() {
      isLoading = false;
      user = jsonDecode(resp.body);
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
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
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
                      DrawerHeader(
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(user['avatar_url']),
                            ),
                            Text(user['name'])
                          ],
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
                        selected: _currentTab == tabGroups,
                        leading: Icon(Icons.group),
                        title: Text(tabs[tabGroups]),
                        onTap: () => _switchTab(tabGroups),
                      ),
                      ListTile(
                        selected: _currentTab == tabTodo,
                        leading: Icon(Icons.view_list),
                        title: Text(tabs[tabTodo]),
                        onTap: () => _switchTab(tabTodo),
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
                        applicationIcon: Icon(Icons.code),
                      )
                    ],
                  ),
                ),
                body: Builder(builder: (context) {
                  switch (_currentTab) {
                    case tabActivity:
                      return Activity();
                      break;
                    case tabProjects:
                      return Project();
                      break;
                    case tabGroups:
                      break;
                    case tabTodo:
                      break;
                  }
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
}
