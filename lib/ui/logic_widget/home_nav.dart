import 'package:F4Lab/const.dart';
import 'package:F4Lab/model/user.dart';
import 'package:F4Lab/providers/theme.dart';
import 'package:F4Lab/providers/user.dart';
import 'package:F4Lab/ui/logic_widget/notification.dart';
import 'package:F4Lab/ui/tabs/activity.dart';
import 'package:F4Lab/ui/tabs/groups.dart';
import 'package:F4Lab/ui/tabs/project.dart';
import 'package:F4Lab/util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class TabItem {
  final IconData icon;
  final String name;
  final WidgetBuilder builder;

  TabItem(this.icon, this.name, this.builder);
}

class _State extends State<HomeNav> {
  int _currentTab = 0;
  List<TabItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      TabItem(Icons.category, "Project", (_) => TabProject()),
      TabItem(Icons.today, "Activity", (_) => TabActivity()),
      TabItem(Icons.group, "Groups", (_) => TabGroups())
    ];
    _loadNavIndexFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final tabs = _items.map<Widget>((item) => item.builder(context)).toList();
    return Scaffold(
      appBar: AppBar(title: Text(_items[_currentTab].name)),
      drawer: _buildNav(context, user, themeProvider, _items),
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            IndexedStack(index: _currentTab, children: tabs),
            NotificationBar()
          ],
        );
      }),
    );
  }

  Drawer _buildNav(BuildContext context, User user, ThemeProvider themeProvider,
      List<TabItem> items) {
    var widgets = List<Widget>();

    final header = UserAccountsDrawerHeader(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
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
      currentAccountPicture: loadAvatar(user.avatarUrl, user.name),
    );
    final tabs = _buildTabNav(items, context);
    final config = ListTile(
      leading: Icon(Icons.settings),
      title: Text("Config"),
      onTap: () => _navigateToConfig(context),
    );
    final about = AboutListTile(
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
    );
    final footer = Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Text("Dark Theme"),
          Switch(
            onChanged: (isDark) => _changeTheme(isDark, themeProvider),
            value: themeProvider.isDark,
          )
        ],
      ),
    );

    widgets.add(header);
    widgets.addAll(tabs);
    widgets.add(config);
    widgets.add(about);
    widgets.add(footer);
    return Drawer(child: ListView(children: widgets));
  }

  List<Widget> _buildTabNav(List<TabItem> items, BuildContext context) {
    return items.map<Widget>((item) {
      final index = items.indexOf(item);
      return ListTile(
        selected: _currentTab == index,
        leading: Icon(item.icon),
        title: Text(item.name),
        onTap: () => _switchTab(item, index, context),
      );
    }).toList();
  }

  void _changeTheme(bool isDark, ThemeProvider themeProvider) {
    if (isDark) {
      themeProvider.switchToDark();
    } else {
      themeProvider.switchToLight();
    }
  }

  void _switchTab(TabItem item, int index, BuildContext context) {
    Navigator.of(context).pop();
    setState(() => _currentTab = index);
    _saveNavIndexToLocal(index);
  }

  void _navigateToConfig(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/config');
  }

  void _saveNavIndexToLocal(int tabIndex) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(KEY_TAB_INDEX, tabIndex);
  }

  void _loadNavIndexFromLocal() {
    SharedPreferences.getInstance()
        .then((sp) => sp.getInt(KEY_TAB_INDEX) ?? 0)
        .then((index) {
      if (mounted) {
        setState(() => _currentTab = index);
      }
    });
  }
}
