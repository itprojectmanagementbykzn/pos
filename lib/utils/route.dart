import 'package:get/get.dart';
import 'package:pos_system/utils/route_url.dart';
import 'package:pos_system/views/screen/inventory_management.dart';
import 'package:pos_system/views/screen/sales_analysis.dart';

import '../views/screen/home_page.dart';
import '../views/screen/login_page.dart';
import '../views/screen/coupon_management.dart';

final getPageRoutes = <GetPage<dynamic>>[
  GetPage(
    name: loginUrl,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: homeUrl,
    page: () => const HomePage(),
  ),
  GetPage(
    name: salesUrl,
    page: () => const SalesAnalysis(),
  ),
  GetPage(
    name: inventoryUrl,
    page: () => const InventoryManagement(),
  ),
  GetPage(
    name: couponUrl,
    page: () => const CouponManagement(),
  ),
];
