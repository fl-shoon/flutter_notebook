import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_notebook/pages/components/riverpod_page.dart';
import 'package:flutter_notebook/router/router.dart';

class NavPage extends StatelessWidget {
  const NavPage() : super(key: const Key('nav_page'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation 2')),
      body: Router(
        routerDelegate: ScaffRouterDelegate(
          routerState: routerState,
          pageBuilder: (state) {
            final pages = [
              if (state.path.contains('rpdpage'))
                const MaterialPage(child: RpDPage()),
              if (state.path.contains('navpage'))
                MaterialPage(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          height: 240.0,
                          width: 240.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/flutter.png'),
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 2.0,
                        height: 2.0,
                      ),
                      ListTile(
                        key: const Key('nav_flutter_url'),
                        onTap: (() {
                          _launchInWeb("flutter");
                        }),
                        title: const Text('Flutter'),
                        subtitle: const Text('documents'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      const Divider(
                        thickness: 2.0,
                        height: 2.0,
                      ),
                      ListTile(
                        key: const Key('nav_qiita_url'),
                        onTap: (() {
                          _launchInWeb("qiita");
                        }),
                        title: const Text('Qiita'),
                        subtitle: const Text('documents'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      const Divider(
                        thickness: 2.0,
                        height: 2.0,
                      ),
                      ListTile(
                        key: const Key('nav_github_url'),
                        onTap: (() {
                          _launchInWeb("medium");
                        }),
                        title: const Text('Medium'),
                        subtitle: const Text('documents'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      const Divider(
                        thickness: 2.0,
                        height: 2.0,
                      ),
                    ],
                  ),
                ),
            ];
            return pages;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
              label: 'next'),
        ],
        currentIndex: routerState.state.path.contains('home') ? 0 : 1,
        onTap: ((value) {
          if (value == 0) {
            routerState.toHomePage();
          } else if (value == 1) {
            routerState.changePath(Uri(path: '/main/rpdpage'));
          }
        }),
      ),
    );
  }

  Future<void> _launchInWeb(String link) async {
    final Uri url;

    if (link == "medium") {
      url = Uri.parse(
          'https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade');
    } else if (link == "qiita") {
      url = Uri.parse('https://qiita.com/vsuine/items/9cf7c2dc9f94b16d85ae');
    } else {
      url = Uri.parse('https://docs.flutter.dev/development/ui/navigation');
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        // mode: LaunchMode.inAppWebView,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
