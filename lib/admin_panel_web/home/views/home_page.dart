import 'package:admin_panel_web/admin_panel_web/app/app.dart';
import 'package:admin_panel_web/core/constances/media_const.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  static Page page() => const MaterialPage(child: HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlowController<HomeState> _controller;

  @override
  void initState() {
    _controller = FlowController(HomeState.dashboard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _SideBar(controller: _controller),
          _FlowPage(controller: _controller),
        ],
      ),
    );
  }
}

class _FlowPage extends StatelessWidget {
  const _FlowPage({
    required FlowController<HomeState> controller,
  }) : _controller = controller;

  final FlowController<HomeState> _controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: FlowBuilder<HomeState>(
        controller: _controller,
        onGeneratePages: onGenerateHomePage,
      ),
    );
  }
}

class _SideBar extends StatelessWidget {
  const _SideBar({
    required FlowController<HomeState> controller,
  }) : _controller = controller;

  final FlowController<HomeState> _controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        shadowColor: organge45,
        elevation: 10,
        child: Column(
          children: [
            vSpace(3),
            SvgPicture.asset(iLogoOrange),
            vSpace(3),
            Divider(
              color: organge,
            ),
            ListTile(
              onTap: () => _controller..update((state) => HomeState.dashboard),
              leading: SvgPicture.asset(iHome),
              title: Text(trans(context).dashBoard),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.order),
              leading: SvgPicture.asset(iOrder),
              title: Text(trans(context).order),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.delegates),
              leading: SvgPicture.asset(iDelegates),
              title: Text(trans(context).delegates),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.vendors),
              leading: SvgPicture.asset(iStors),
              title: Text(trans(context).vendors),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.vehicle),
              leading: SvgPicture.asset(iVehicle),
              title: Text(trans(context).vehicle),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.customers),
              leading: SvgPicture.asset(iUsers),
              title: Text(trans(context).users),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.products),
              leading: SvgPicture.asset(iProduct),
              title: Text(trans(context).product),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.banners),
              leading: SvgPicture.asset(iBanner),
              title: Text(trans(context).banner),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.categories),
              leading: SvgPicture.asset(iCategory),
              title: Text(trans(context).categories),
            ),
            ListTile(
              onTap: () =>
                  _controller.update((state) => HomeState.notification),
              leading: Icon(Icons.notifications, color: organge),
              title: Text(trans(context).notification),
            ),
            ListTile(
              onTap: () => _controller.update((state) => HomeState.settings),
              leading: Icon(Icons.settings, color: organge),
              title: Text(trans(context).settings),
            ),
            ListTile(
              onTap: () =>
                  context.read<AppBloc>().add(const AppLogoutRequest()),
              leading: Icon(Icons.logout, color: organge),
              title: Text(trans(context).signOut),
            ),
          ],
        ),
      ),
    );
  }
}
