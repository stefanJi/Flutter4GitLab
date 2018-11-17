import 'package:F4Lab/const.dart';
import 'package:F4Lab/gitlab_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConfigState();
}

class ConfigState extends State<ConfigPage> {
  String _token, _host;
  bool isTesting = false;
  BuildContext rootContext;

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (_token == null ||
              _host == null ||
              _token.isEmpty ||
              _host.isEmpty) {
            return;
          }
          _testConfig();
        },
        tooltip: "Test & Save",
        child: Icon(Icons.save),
      ),
    );
  }

  _testConfig() async {
    setState(() {
      isTesting = true;
    });

    GitlabClient.setUpTokenAndHost(_token, _host);
    final GitlabClient client = GitlabClient();
    final http.Response resp = await client.get('user').catchError((err) {
      setState(() {
        isTesting = false;
      });
      Scaffold.of(rootContext).showSnackBar(SnackBar(content: Text("Error: $err"), backgroundColor: Colors.red));
    }).whenComplete(client.close);
    if (resp == null) {
      return;
    }
    if (resp.statusCode != 200) {
      var msg = resp.body;
      switch (resp.statusCode) {
        case 401:
          msg = 'Unauthorized';
          break;
        case 403:
          msg = 'Forbidden';
          break;
      }
      Scaffold.of(rootContext).showSnackBar(SnackBar(
          content: Text("${resp.statusCode} $msg"),
          backgroundColor: Colors.red));
    } else {
      Scaffold.of(rootContext)
          .showSnackBar(SnackBar(content: Text("Connection Success")));

      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(KEY_ACCESS_TOKEN, _token);
      sp.setString(KEY_HOST, _host);
      Future.delayed(
          Duration(milliseconds: 300), () => Navigator.pop(context, true));
    }

    setState(() {
      isTesting = false;
    });
  }

  _loadConfig() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _token = sp.getString(KEY_ACCESS_TOKEN);
      _host = sp.getString(KEY_HOST);
    });
  }
}
