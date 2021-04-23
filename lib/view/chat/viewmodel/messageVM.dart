import '../../../core/base/model/base_view_model.dart';
import '../model/messageModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'messageVM.g.dart';

class MessageViewModel = _MessageViewModelBase with _$ChatViewModel;

abstract class _MessageViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {}

  var tfController = TextEditingController();

  @observable
  List<MessageModel> chatTextList = [
    MessageModel('Hello,V.İ.Lenin', 0, false, '1.43 PM'),
    MessageModel('Are you busy tomorrow?', 0, false, '1.44 PM'),
    MessageModel('Tomorrow I want to go to the park do you want to come', 0, true, '1.46 PM'),
    MessageModel('looks fun, yes I will go along', 1, false, '1.47 PM'),
    MessageModel('But can I take my friend?', 1, true, '1.47 PM'),
    MessageModel('of course', 0, true, '1.47 PM'),
    MessageModel('Thanks, M.K.Atatürk', 1, true, '1.47 PM'),
    MessageModel('You\'r welcome', 0, true, '1.49 PM'),
  ];

  @observable
  bool isText = false;

  @action
  void isEmptyText(String text) {
    isText = text.isNotEmpty;
  }

  @action
  void sendMessage(String text) {
    chatTextList.add(MessageModel(tfController.text, 1, true, DateFormat('hh:mm a').format(DateTime.now()).toString()));
    chatTextList = chatTextList;
    tfController.text = '';
  }
}
