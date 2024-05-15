import 'package:ecom_flutter/features/dashboard/presentation/pages/mobile/dashboard_mobile_view.dart';
import 'package:ecom_flutter/widgets/responsive.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveView(
      mobile: DashboardMobileView(),
    );
  }
}
