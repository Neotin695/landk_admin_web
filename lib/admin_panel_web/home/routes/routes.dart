import 'package:admin_panel_web/admin_panel_web/banner/view/banner_page.dart';
import 'package:admin_panel_web/admin_panel_web/delegates/view/manage_delegate_page.dart';
import 'package:admin_panel_web/admin_panel_web/manage_user/view/manage_user_page.dart';
import 'package:admin_panel_web/admin_panel_web/orders/view/order_page.dart';
import 'package:admin_panel_web/admin_panel_web/product/view/product_page.dart';
import 'package:admin_panel_web/admin_panel_web/vehicle/view/vehicle_page.dart';
import 'package:flutter/material.dart';

import '../../category/view/category_page.dart';
import '../../notification/view/notification_page.dart';
import '../../settings/view/settings_page.dart';
import '../../vendors/view/vendor_page.dart';
import '../views/dashboard_page.dart';

enum HomeState {
  dashboard,
  vendors,
  products,
  customers,
  banners,
  settings,
  notification,
  delegates,
  categories,
  vehicle,
  order,
}

List<Page> onGenerateHomePage(HomeState state, List<Page> pages) {
  switch (state) {
    case HomeState.dashboard:
      return [DashboardPage.page()];
    case HomeState.vendors:
      return [VendorPage.page()];
    case HomeState.order:
      return [Orderpage.page()];
    case HomeState.products:
      return [ProductPage.page()];
    case HomeState.customers:
      return [ManageUserPage.page()];
    case HomeState.banners:
      return [BannerPage.page()];
    case HomeState.vehicle:
      return [VehiclePage.page()];
    case HomeState.settings:
      return [SettingsPage.page()];
    case HomeState.notification:
      return [NotificationPage.page()];
    case HomeState.delegates:
      return [DelegatesPage.page()];
    case HomeState.categories:
      return [CategoryPage.page()];
  }
}
