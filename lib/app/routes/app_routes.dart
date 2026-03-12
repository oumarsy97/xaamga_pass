part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const initial = _Paths.initial;
  static const main = _Paths.main;
  static const home = _Paths.home;
  static const dashboard = _Paths.dashboard;
  static const events = _Paths.events;
  static const eventDetail = _Paths.eventDetail;
  static const eventCreate = _Paths.eventCreate;
  static const scanner = _Paths.scanner;
  static const settings = _Paths.settings;
  static const login = _Paths.login;
  static const guichet = _Paths.guichet;
  static const checking = _Paths.checking;
  static const drink = _Paths.drink;
  static const food = _Paths.food;
  static const users = _Paths.users;
}

abstract class _Paths {
  _Paths._();
  static const initial = '/';
  static const home = '/home';
  static const main = '/main';
  static const dashboard = '/dashboard';
  static const events = '/events';
  static const eventDetail = '/event-detail';
  static const eventCreate = '/event-create';
  static const scanner = '/scanner';
  static const settings = '/settings';
  static const login = '/login';
  static const guichet = '/guichet';
  static const checking = '/checking';
  static const drink = '/drink';
  static const food = '/food';
  static const users = '/users';
}
