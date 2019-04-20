import 'package:F4Lab/api.dart';
import 'package:F4Lab/const.dart';
import 'package:F4Lab/gitlab_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConfigState();
}

class ConfigState extends State<ConfigPage> {
  String _token, _host;
  bool isTesting = false;
  BuildContext rootContext;
  String _err;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Config"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Builder(
        builder: (context) {
          rootContext = context;
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
                  _err != null
                      ? Text(_err, style: TextStyle(color: Colors.red))
                      : const IgnorePointer(ignoring: true),
                  isTesting
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
                        child: Text("Test & Save 👏"),
                        onPressed: () {
                          if (_token == null ||
                              _host == null ||
                              _token.isEmpty ||
                              _host.isEmpty) {
                            return;
                          }
                          _testConfig();
                        },
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: OutlineButton(
                        child: Text("Reset 🙊"),
                        onPressed: () => _reset(),
                      ),
                      flex: 1,
                    ),
                  ],
                ));
          }),
    );
  }

  _testConfig() async {
    setState(() {
      isTesting = true;
      _err = null;
    });

    GitlabClient.setUpTokenAndHost(_token, _host);
    final resp = await ApiService.getAuthUser();
    if (resp.success && resp.data != null) {
      Scaffold.of(rootContext).showSnackBar(
        SnackBar(content: Text("Connection Success")),
      );
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(KEY_ACCESS_TOKEN, _token);
      sp.setString(KEY_HOST, _host);
      Future.delayed(
          Duration(milliseconds: 300), () => Navigator.pop(context, 0));
    } else {
      Scaffold.of(rootContext).showSnackBar(SnackBar(
          content: Text(resp.err ?? "Error"), backgroundColor: Colors.red));
    }

    setState(() {
      isTesting = false;
      _err = resp.err;
    });
  }

  _loadConfig() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _token = sp.getString(KEY_ACCESS_TOKEN);
      _host = sp.getString(KEY_HOST);
    });
  }

  _reset() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove(KEY_HOST);
    sp.remove(KEY_ACCESS_TOKEN);
    Navigator.pop(context, -1);
  }
}
