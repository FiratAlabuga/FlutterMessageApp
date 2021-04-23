import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/view/home/model/messageModelCollabration.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/components/circleavatar/profileAvatar.dart';
import '../../../core/components/container/messagePage.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../viewmodel/messageVM.dart';

class ChatView extends StatelessWidget {
  final MessageModelCollobration model;

  const ChatView({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<MessageViewModel>(
      viewModel: MessageViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, MessageViewModel viewModel) => Scaffold(
        backgroundColor: context.colorScheme.background,
        appBar: buildPreferredSizeAppBar(context),
        body: Column(
          children: [
            Expanded(flex: 2, child: buildContainerChatBackground(context, viewModel)),
          ],
        ),
      ),
    );
  }

  Container buildContainerChatBackground(BuildContext context, MessageViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: buildCenterChatMain(context, viewModel),
    );
  }

  Center buildCenterChatMain(BuildContext context, MessageViewModel viewModel) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.lowValue, vertical: context.mediumValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            buildTextDate(context),
            Spacer(),
            Expanded(flex: 25, child: buildListViewChatBubble(viewModel)),
            Expanded(
              flex: 3,
              child: buildRowChatBottom(context, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Row buildRowChatBottom(BuildContext context, MessageViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: context.dynamicWidth(0.7), child: messageTextField(context, viewModel)),
        buildCircleAvatarSendButton(context, viewModel),
      ],
    );
  }

  CircleAvatar buildCircleAvatarSendButton(BuildContext context, MessageViewModel viewModel) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.background,
      radius: 26,
      child: Observer(
        builder: (_) {
          return IconButton(
            icon: Icon(
              viewModel.isText ? Icons.send : Icons.mic_none,
              color: context.colorScheme.secondary,
              size: 32,
            ),
            onPressed: () => viewModel.sendMessage('hiiii'),
          );
        },
      ),
    );
  }

  Text buildTextDate(BuildContext context) {
    return Text(
      LocaleKeys.chat_date.tr(),
      style: context.textTheme.subtitle2!.copyWith(color: context.colorScheme.surface, fontWeight: FontWeight.bold),
    );
  }

  ListView buildListViewChatBubble(MessageViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.chatTextList.length,
      itemBuilder: (context, index) {
        return Observer(builder: (_) {
          //Observer Çalışmıyo :(
          return MessagePage(model: viewModel.chatTextList[index]);
        });
      },
    );
  }

  PreferredSize buildPreferredSizeAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(context.dynamicHeight(0.14)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.02)),
        child: AppBar(
          title: buildRowTitle(context),
          centerTitle: false,
          actions: [
            buildIconActions(context, Icons.video_call_outlined),
            buildIconActions(context, Icons.call_outlined),
          ],
        ),
      ),
    );
  }

  Widget buildIconActions(BuildContext context, IconData icon) => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.03)),
        child: Icon(
          icon,
          size: 40,
          color: context.colorScheme.secondary.withOpacity(0.7),
        ),
      );

  Row buildRowTitle(BuildContext context) {
    return Row(
      children: [
        CircleProfile(size: 30),
        context.emptySizedWidthBoxLow,
        buildColumnText(context),
      ],
    );
  }

  Column buildColumnText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          style: context.textTheme.headline6!.copyWith(color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
        context.emptySizedHeightBoxLow,
        Text(
          LocaleKeys.chat_online.tr(),
          style: context.textTheme.subtitle2!.copyWith(color: context.colorScheme.onPrimary, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

Widget messageTextField(BuildContext context, MessageViewModel viewModel) {
  return Observer(builder: (_) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        onChanged: (value) {
          viewModel.isEmptyText(value);
        },
        controller: viewModel.tfController,
        style: context.textTheme.headline6!,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.tag_faces_rounded, size: 25),
          suffixIcon: Icon(Icons.attach_file_rounded, size: 25),
          contentPadding: context.paddingLow,
          hintText: 'Type a message...',
          hintStyle: context.textTheme.subtitle1!.copyWith(color: context.colorScheme.primary.withOpacity(0.5), fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: context.colorScheme.surface.withOpacity(0.3),
        ),
      ),
    );
  });
}
