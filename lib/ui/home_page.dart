import 'package:F4Lab/providers/package_info.dart';
import 'package:F4Lab/providers/user.dart';
import 'package:F4Lab/ui/home_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.loading) {
      return _buildLoading();
    }
    if (userProvider.user == null) {
      return _buildWelcome(context);
    }
    return HomeNav();
  }

  Widget _buildLoading() =>
      Scaffold(body: Center(child: CircularProgressIndicator()));

  Widget _buildWelcome(BuildContext context) {
    final provider = Provider.of<PackageInfoProvider>(context);
    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                provider.packageInfo.appName,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 5),
                          color: Theme.of(context).accentColor,
                          blurRadius: 20)
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(children: <Widget>[
                Text("👇", style: TextStyle(fontSize: 50)),
                OutlineButton(
                  onPressed: () => _navigateToConfig(context),
                  child: Text("Config Access_Token & Host"),
                ),
              ]),
            )
          ],
        ),
      ),
    ));
  }

  void _navigateToConfig(BuildContext context) {
    Navigator.pushNamed(context, '/config');
  }
}
