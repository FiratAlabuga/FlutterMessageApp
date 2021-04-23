
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/components/circleavatar/textAvatar.dart';
import '../../../core/components/list/messageList.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../viewmodel/homeVM.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) => Scaffold(
        backgroundColor: context.colorScheme.secondaryVariant,
        appBar: buildAppBar(context),
        body: buildPaddingBody(context, viewModel),
        bottomNavigationBar: buildContainerBottomNavigationBar(context),
      ),
    );
  }

  Padding buildPaddingBody(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.05), vertical: context.lowValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextActivity(context, LocaleKeys.home_activity.tr()),
          buildExpandedCircleProfiles(viewModel),
          buildTextActivity(context, LocaleKeys.home_messages.tr()),
          context.emptySizedHeightBoxNormal,
          Expanded(flex: 3, child: buildListViewForMessages(viewModel))
        ],
      ),
    );
  }

  ListView buildListViewForMessages(HomeViewModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.chatList.length,
      itemExtent: 90,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () => NavigationService.instance.navigateToPage(path: NavigationConstants.CHAT, object: viewModel.chatList[index]),
            child: MessageListTile(model: viewModel.chatList[index]));
      },
    );
  }

  Expanded buildExpandedCircleProfiles(HomeViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLow,
            child: CircleProfileText(
              model: viewModel.users[index],
              size: 25,
            ),
          );
        },
      ),
    );
  }

  Text buildTextActivity(BuildContext context, String data) {
    return Text(
      data,
      style: context.textTheme.headline6!.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.01)),
        child: buildTextTitle(context),
      ),
      centerTitle: false,
      actions: [
        buildIconButtonAppBar(context,Icon(Icons.search)),
        buildIconButtonAppBar(context,Icon(Icons.dehaze_rounded)),
      ],
    );
  }

  Text buildTextTitle(BuildContext context) {
    return Text(
      LocaleKeys.home_laViva.tr(),
      style: context.textTheme.headline5!.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
    );
  }

  IconButton buildIconButtonAppBar(BuildContext context,Icon icon) => IconButton(
        icon: icon,
        color: context.colorScheme.error,
        onPressed: () {},
        iconSize:30,
      );
}

Container buildContainerBottomNavigationBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: context.colorScheme.background,
    ),
    width: context.width,
    height: context.dynamicHeight(0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildIconButtonBottomNavigationBar(context, Icons.chat_bubble_outline_rounded),
        buildIconButtonBottomNavigationBar(context, Icons.call_outlined),
        buildIconButtonBottomNavigationBar(context, Icons.camera_alt_outlined),
        buildIconButtonBottomNavigationBar(context, Icons.settings_rounded),
      ],
    ),
  );
}

IconButton buildIconButtonBottomNavigationBar(BuildContext context, IconData icon) =>
    IconButton(icon: Icon(icon, color: context.colorScheme.onPrimary, size: context.dynamicWidth(0.08)), onPressed: () {});
