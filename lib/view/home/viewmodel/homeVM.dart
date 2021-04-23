import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/core/constants/image/image_constants.dart';
import 'package:flutter_chat_ui/view/home/model/messageModelCollabration.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_view_model.dart';
import '../model/profile_model.dart';

part 'homeVM.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  final List<ProfileModel> users = [
    ProfileModel('V.İ.Lenin'),
    ProfileModel('J.Stalin'),
    ProfileModel('M.Gandhi'),
    ProfileModel('M.K.Atatürk'),
    ProfileModel('N.Mandela'),
    ProfileModel('K.Marx'),
  ];

  final List<MessageModelCollobration> chatList = [
    MessageModelCollobration('V.İ.Lenin', 'Şiddet,elbette, bizim düşüncelerimize yabancıdır', '27min', 1),
    MessageModelCollobration('M.K.Atatürk', 'Egemenlik kayıtsız şartsız milletindir', '20min', 2),
    MessageModelCollobration('K.Marx', 'Cehalet; ayrıcalıklı sınıfın ustaca kullandığı bir silahtır', '27min', 3),
    MessageModelCollobration('N.Mandela', 'Dünyayı değiştirmek için kullanabileceğiniz en güçlü silah eğitimdir', '27min', 4),
  ];

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    
  }
}
