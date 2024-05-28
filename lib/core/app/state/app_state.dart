import 'package:flutter/cupertino.dart';
import 'package:hba_management/layers/data/repository/profile_repository.dart';

import '../../../injection_container.dart';
import '../../../layers/data/model/user_model.dart';

class AppState extends ChangeNotifier {
  final _profileRpo = sl<ProfileRepository>();

  UserModel? userModel;

  Future init() async {
    await getUserProfile();
  }

  Future getUserProfile() async {
    userModel = await _profileRpo.getUserProfile();
  }
}
