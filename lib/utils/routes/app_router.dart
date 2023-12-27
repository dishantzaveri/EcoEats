import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: MainScaffoldRoute.page),
        AutoRoute(page: NotificationsRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: EditProfileRoute.page),
      ];
}
