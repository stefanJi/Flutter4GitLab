import 'package:F4Lab/const.dart';
import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigState();
}

class _ConfigState extends State<ConfigPage> {
  String _token, _host, _version;
  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    if (userProvider.testSuccess) {
      Navigator.pop(context);
      userProvider.resetTestState();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Config"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Builder(
        builder: (context) {
          return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: _token ?? "Access Token:",
                        helperText:
                            "You can create personal access token from your GitLab profile."),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.url,
                    onChanged: (token) => _token = token,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: _host ?? "GitLab Host:",
                        helperText: "Like https://gitlab.example.com"),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                    onChanged: (host) => _host = host,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: _version ?? "Your gitlab api version",
                        helperText: "Api version, default v4"),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    onChanged: (v) => _version = v,
                  ),
                  userProvider.testErr != null
                      ? Text(userProvider.testErr,
                          style: TextStyle(color: Colors.red))
                      : const IgnorePointer(ignoring: true),
                  userProvider.testing
                      ? Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Text("Test connectiong")
                          ],
                        )
                      : const IgnorePointer(ignoring: true),
                ],
              ));
        },
      ),
      bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        child: Text("Test&Save"),
                        onPressed: () {
                          if (_token == null ||
                              _host == null ||
                              _token.isEmpty ||
                              _host.isEmpty) {
                            return;
                          }
                          _testConfig(context);
                        },
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("Reset"),
                        onPressed: () => _reset(),
                      ),
                      flex: 1,
                    ),
                  ],
                ));
          }),
    );
  }

  void _testConfig(BuildContext context) {
    userProvider.testConfig(_host, _token, _version);
  }

  void _loadConfig() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _token = sp.getString(KEY_ACCESS_TOKEN);
      _host = sp.getString(KEY_HOST);
      _version = sp.getString(KEY_API_VERSION) ?? DEFAULT_API_VERSION;
    });
  }

  void _reset() {
    Navigator.pop(context);
    userProvider.logOut();
  }
}
