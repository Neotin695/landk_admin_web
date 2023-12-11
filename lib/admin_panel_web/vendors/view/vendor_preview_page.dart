import 'package:flutter/material.dart';

import '../vendors_repository/vendors_repository.dart';

class VendorPreviewPage extends StatefulWidget {
  const VendorPreviewPage({super.key, required this.store});
  final Store store;
  @override
  State<VendorPreviewPage> createState() => _VendorPreviewPageState();
}

class _VendorPreviewPageState extends State<VendorPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
