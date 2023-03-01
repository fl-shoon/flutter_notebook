import 'package:flutter/material.dart';

final routerState = RouterState();

class RouterState with ChangeNotifier {
  Uri _state = Uri(path: '/');
  Uri get state => _state;

  void changePath(Uri value) {
    _state = value;
    notifyListeners();
  }

  void toHomePage() {
    final p = _state.path.split('/');
    p.removeLast();
    changePath(Uri(path: p.join('/')));
  }
}

class ScaffRouteInformationParser extends RouteInformationParser<Uri> {
  const ScaffRouteInformationParser() : super();

  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    Uri uri = Uri.parse(routeInformation.location!);
    if (uri.path.isEmpty || uri.path == '/') {
      uri = Uri(path: '/main/home');
    }
    return uri;
  }

  @override
  RouteInformation? restoreRouteInformation(configuration) {
    return RouteInformation(location: configuration.path);
  }
}

class ScaffRouterDelegate extends RouterDelegate<Uri>
    with PopNavigatorRouterDelegateMixin {
  final List<Page> Function(Uri state) pageBuilder;
  final RouterState routerState;

  ScaffRouterDelegate({required this.pageBuilder, required this.routerState});

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void addListener(VoidCallback listener) {
    routerState.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    routerState.removeListener(listener);
  }

  @override
  Uri? get currentConfiguration {
    return routerState.state;
  }

  @override
  Future<void> setNewRoutePath(Uri configuration) async {
    routerState.changePath(configuration);
  }

  @override
  Future<void> setRestoredRoutePath(Uri configuration) {
    return super.setRestoredRoutePath(configuration);
  }

  @override
  Widget build(BuildContext context) {
    final pages = pageBuilder(currentConfiguration!);
    if (pages.isEmpty) {
      pages.add(const MaterialPage(child: Scaffold()));
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        routerState.toHomePage();
        return route.didPop(result);
      },
    );
  }
}
