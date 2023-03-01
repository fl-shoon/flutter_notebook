import 'package:flutter/material.dart';
import 'package:flutter_notebook/pages/components/riverpod_page.dart';
import 'package:flutter_notebook/router/router.dart';

class RxDPage extends StatelessWidget {
  const RxDPage() : super(key: const Key('rxd_page'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RxDart')),
      body: Router(
        routerDelegate: ScaffRouterDelegate(
          routerState: routerState,
          pageBuilder: (state) {
            final pages = [
              if (state.path.contains('rpdpage'))
                const MaterialPage(child: RpDPage()),
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
}
