import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../core/models/user.dart';
import '../../../core/repositories/profile_repository.dart';

class ProfileViewModel extends BaseViewModel {
  final ProfileRepository _repo = locator<ProfileRepository>();

  User? me;
  List<String> myPosts = [];

  Future<void> init() async {
    setBusy(true);
    try {
      final res = await Future.wait([
        _repo.getMe(),
        _repo.getMyPosts(),
      ]);
      me = res[0] as User;
      myPosts = res[1] as List<String>;
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> refresh() => init();

  void editProfile() {}
  void addPerson() {}
}
