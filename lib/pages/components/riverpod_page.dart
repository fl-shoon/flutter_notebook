import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_notebook/pages/components/nav_page.dart';
import 'package:flutter_notebook/pages/components/rxdart_page.dart';
import 'package:flutter_notebook/router/router.dart';
import 'package:flutter_notebook/pages/todo/todoapp.dart';

class RpDPage extends StatelessWidget {
  const RpDPage() : super(key: const Key('rpd_page'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Riverpod')),
      body: Router(
        routerDelegate: ScaffRouterDelegate(
          routerState: routerState,
          pageBuilder: (state) {
            final pages = [
              if (state.path.contains('navpage'))
                const MaterialPage(child: NavPage()),
              if (state.path.contains('rxdpage'))
                const MaterialPage(child: RxDPage()),
              if (state.path.contains('rpdpage'))
                MaterialPage(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TodoWidget(),
                      ),
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
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
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
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
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                          const Divider(
                            thickness: 2.0,
                            height: 2.0,
                          ),
                          ListTile(
                            key: const Key('nav_github_url'),
                            onTap: (() {
                              _launchInWeb("github");
                            }),
                            title: const Text('GitHub'),
                            subtitle: const Text('documents'),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                          const Divider(
                            thickness: 2.0,
                            height: 2.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // child:
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
                Icons.arrow_back_ios,
              ),
              label: 'back'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
              label: 'next'),
        ],
        onTap: ((value) {
          if (value == 0) {
            routerState.toHomePage();
          } else if (value == 1) {
            routerState.changePath(Uri(path: '/main/navpage'));
          } else if (value == 2) {
            routerState.changePath(Uri(path: '/main/rxdpage'));
          }
        }),
      ),
    );
  }

  Future<void> _launchInWeb(String link) async {
    final Uri url;

    if (link == "github") {
      url = Uri.parse(
          'https://github.com/rrousselGit/riverpod/tree/master/examples/todos');
    } else if (link == "qiita") {
      url =
          Uri.parse('https://qiita.com/hammer0802/items/0a12d129222441a3a91c');
    } else {
      url = Uri.parse('https://docs-v2.riverpod.dev/docs/introduction');
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
