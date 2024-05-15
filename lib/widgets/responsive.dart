import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

double getResponsiveValue(BuildContext context, double baseValue) {
  // Define scaling factors for different screen widths
  // Adjust these values to suit your design preferences
  if (ResponsiveBreakpoints.of(context).isMobile) {
    // Small screen size
    return baseValue * 0.8;
  }
  // else if (ResponsiveBreakpoints.of(context).isTablet) {
  // Medium screen size
  return baseValue;
  // } else {
  //   // Large screen size
  //   return baseValue * 1.15;
  // }
}

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({
    Key? key,
    required this.mobile,
    this.desktop,
    this.tablet,
  }) : super(key: key);

  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isTablet) {
      return tablet ??
          const Center(
            child: Text("Tablet View"),
          );
    } else if (ResponsiveBreakpoints.of(context).isDesktop) {
      return desktop ?? tablet ?? const Center(child: Text("Desktop View"));
    } else {
      return mobile ??
          const Center(
            child: Text("Mobile View"),
          );
    }
  }
}
