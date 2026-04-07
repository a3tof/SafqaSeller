import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/profile/model/repositories/profile_repository.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model_state.dart';

class ProfileViewModel extends Cubit<ProfileViewModelState> {
  final CacheHelper cacheHelper;
  final ProfileRepository profileRepository;

  ProfileViewModel({
    required this.cacheHelper,
    required this.profileRepository,
  }) : super(ProfileInitial());

  /// Restores isProfileCompleted from SharedPreferences on app start.
  /// Does NOT fetch user data from the network — call [fetchProfile] for that.
  void loadFromCache() {
    final isCompleted =
        (cacheHelper.getData(key: CacheKeys.isProfileCompleted) as bool?) ??
            false;
    final current = state;
    emit(ProfileLoaded(
      isProfileCompleted: isCompleted,
      fullName: current is ProfileLoaded ? current.fullName : null,
      email: current is ProfileLoaded ? current.email : null,
      phoneNumber: current is ProfileLoaded ? current.phoneNumber : null,
      logoBytes: current is ProfileLoaded ? current.logoBytes : null,
      rating: current is ProfileLoaded ? current.rating : null,
      followersCount: current is ProfileLoaded ? current.followersCount : null,
      auctionsCount: current is ProfileLoaded ? current.auctionsCount : null,
    ));
  }

  /// Fetches the user profile (name, email, phone, logo) from
  /// GET seller/business-account and merges into state.
  Future<void> fetchProfile() async {
    final isCompleted =
        (cacheHelper.getData(key: CacheKeys.isProfileCompleted) as bool?) ??
            false;
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileLoaded(
        isProfileCompleted: isCompleted,
        fullName: profile.fullName,
        email: profile.email,
        phoneNumber: profile.phoneNumber,
        logoBytes: profile.logoBytes,
        rating: profile.rating,
        followersCount: profile.followersCount,
        auctionsCount: profile.auctionsCount,
      ));
    } catch (e) {
      emit(ProfileError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Returns whether the profile is completed.
  bool get isProfileCompleted {
    final s = state;
    if (s is ProfileLoaded) return s.isProfileCompleted;
    return false;
  }

  /// Marks profile as completed in cache + emits updated state.
  Future<void> completeProfile() async {
    await cacheHelper.saveData(
      key: CacheKeys.isProfileCompleted,
      value: true,
    );
    final current = state;
    emit(ProfileLoaded(
      isProfileCompleted: true,
      fullName: current is ProfileLoaded ? current.fullName : null,
      email: current is ProfileLoaded ? current.email : null,
      phoneNumber: current is ProfileLoaded ? current.phoneNumber : null,
      logoBytes: current is ProfileLoaded ? current.logoBytes : null,
      rating: current is ProfileLoaded ? current.rating : null,
      followersCount: current is ProfileLoaded ? current.followersCount : null,
      auctionsCount: current is ProfileLoaded ? current.auctionsCount : null,
    ));
  }

  /// Resets profile completion (used on logout).
  Future<void> reset() async {
    await cacheHelper.removeData(key: CacheKeys.isProfileCompleted);
    emit(const ProfileLoaded(isProfileCompleted: false));
  }
}
