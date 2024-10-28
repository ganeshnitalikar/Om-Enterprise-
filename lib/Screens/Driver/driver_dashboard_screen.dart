import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/driver_dashboard_controller.dart';

import 'package:om/Services/shared_preferences_service.dart';
import 'package:om/Utils/utils.dart';

class DriverDashboard extends StatelessWidget {
  final DriverDashboardController controller =
      Get.put(DriverDashboardController());
  final String username = sharedPrefs.getusername();

  DriverDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: buildAppBar(theme: Get.theme, title: "Driver Dashboard"),
      drawer: _buildDrawer(theme),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome, ",
                              style: theme.textTheme.headlineLarge!.copyWith(
                                  color: theme.colorScheme.onSurface)),
                          Text(controller.name.value,
                              style: theme.textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Route Name: ",
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Text(
                              controller.routeName.value,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Placeholder(
                  fallbackHeight: 200,
                  fallbackWidth: MediaQuery.of(context).size.width,
                  child:
                      const Center(child: Text("Graph will be displayed here")),
                ),
                const SizedBox(height: 20),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller
                                  .fetchDriverDetails(sharedPrefs.getEmpId());
                            },
                            icon: const Icon(Icons.refresh)),
                        _buildDashboardCards(theme),
                      ],
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDrawer(ThemeData theme) {
    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor,
      elevation: theme.drawerTheme.elevation,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.drawerTheme.backgroundColor,
            ),
            child: Center(
              child: Text('Menu',
                  style: theme.textTheme.headlineLarge
                      ?.copyWith(color: theme.drawerTheme.scrimColor)),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: 'Dashboard',
            onTap: () {
              Get.toNamed('/driverDashboard');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.store,
            text: 'Shop Sales',
            onTap: () {
              Get.toNamed('/driverShopSales');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.store,
            text: 'Shops On Route',
            onTap: () {
              Get.toNamed('/driverShopOnRoute');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.sms_failed,
            text: 'Personal Expense',
            onTap: () {
              Get.toNamed('/driverExpense');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.report,
            text: 'Report',
            onTap: () {
              Get.toNamed('/driverReport');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.money,
            text: 'Cash Settlement',
            onTap: () {
              Get.toNamed('/driverCashSettlement');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.warning,
            text: 'Expiry Material',
            onTap: () {
              Get.toNamed('/driverExpiryMaterial');
            },
            theme: theme,
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              sharedPrefs.clearPreferences();
              Get.offAllNamed('/');
            },
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap,
      required ThemeData theme}) {
    return ListTile(
      leading: Icon(icon, color: theme.iconTheme.color),
      title: Text(
        text,
        style: theme.textTheme.bodyLarge!
            .copyWith(color: theme.colorScheme.onSurface),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDashboardCards(ThemeData theme) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DashboardCard(
              title: 'Total Sale',
              value: controller.totalSale.value,
              isSale: true,
            ),
            DashboardCard(
                title: "Total Material", value: controller.totalMaterial.value),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DashboardCard(
                title: 'Total Expense', value: controller.totalExpense.value),
            DashboardCard(
                title: 'Current In Vehicle',
                value: controller.currentInVehicle.value),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashboardCard(
                title: 'Total Discount', value: controller.totalDiscount.value),
          ],
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final double value;
  final bool isSale;

  const DashboardCard(
      {super.key,
      required this.title,
      required this.value,
      this.isSale = false});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      color: theme.cardTheme.color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: isSale
          ? InkWell(
              onTap: () {
                Get.toNamed('/driverShopOnRoute');
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10),
                height: MediaQuery.of(context).size.height / 6.7,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  color: theme.cardTheme.color,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    Text('$value',
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.inverseSurface)),
                  ],
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.only(top: 10, left: 10),
              height: MediaQuery.of(context).size.height / 6.7,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                color: theme.cardTheme.color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.primary, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  Text('$value',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: theme.colorScheme.inverseSurface)),
                ],
              ),
            ),
    );
  }
}
