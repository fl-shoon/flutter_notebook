import 'package:flutter/material.dart';
import 'package:flutter_notebook/router/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_notebook/etc/style.dart';
import 'package:flutter_notebook/pages/components/nav_page.dart';
import 'package:flutter_notebook/pages/components/riverpod_page.dart';
import 'package:flutter_notebook/pages/components/rxdart_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());

  // runApp(const MainApp());
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp() : super(key: const Key('main_page'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: const String.fromEnvironment('APP_NAME'),
      themeMode: ThemeMode.system,
      theme: getTheme(Style.light),
      darkTheme: getTheme(Style.dark),
      debugShowCheckedModeBanner: false,
      routeInformationParser: const ScaffRouteInformationParser(),
      routerDelegate: ScaffRouterDelegate(
        routerState: routerState,
        pageBuilder: (state) {
          final pages = [
            MaterialPage(
              child: Scaffold(
                key: const Key('home'),
                appBar: AppBar(title: const Text('Home')),
                body: ListView(children: [
                  ListTile(
                    key: const Key('home_btn_nav_page'),
                    onTap: (() {
                      routerState.changePath(Uri(path: '/main/navpage'));
                    }),
                    title: const Text('Navigator_2'),
                    subtitle: const Text('Contents'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    key: const Key('home_btn_riverpod_page'),
                    onTap: (() {
                      routerState.changePath(Uri(path: '/main/rpdpage'));
                    }),
                    title: const Text('Riverpod'),
                    subtitle: const Text('Contents'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    key: const Key('home_btn_rxdart_page'),
                    onTap: (() {
                      routerState.changePath(Uri(path: '/main/rxdpage'));
                    }),
                    title: const Text('RxDart'),
                    subtitle: const Text('Contents'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ]),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.zoom_out_map_outlined), label: 'nav'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list), label: 'riverpod'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: 'rxdart'),
                  ],
                  onTap: ((value) {
                    if (value == 0) {
                      routerState.changePath(Uri(path: '/main/navpage'));
                    } else if (value == 1) {
                      routerState.changePath(Uri(path: '/main/rpdpage'));
                    } else if (value == 2) {
                      routerState.changePath(Uri(path: '/main/rxdpage'));
                    }
                  }),
                ),
              ),
            ),
            if (state.path.contains('navpage'))
              const MaterialPage(child: NavPage()),
            if (state.path.contains('rpdpage'))
              const MaterialPage(child: RpDPage()),
            if (state.path.contains('rxdpage'))
              const MaterialPage(child: RxDPage()),
          ];
          return pages;
        },
      ),
    );
  }
}
