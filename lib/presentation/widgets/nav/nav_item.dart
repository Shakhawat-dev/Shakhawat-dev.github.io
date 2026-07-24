import 'package:flutter/widgets.dart';

/// One entry in the top nav — a label paired with the [GlobalKey] of the
/// section it should scroll to.
class NavItem {
  const NavItem({required this.label, required this.sectionKey});

  final String label;
  final GlobalKey sectionKey;
}
