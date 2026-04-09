import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/change_password/model/models/change_password_models.dart';
import 'package:safqaseller/features/change_password/model/repositories/change_password_repository.dart';
import 'package:safqaseller/features/change_password/view_model/change_password/change_password_view_model_state.dart';

class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  ChangePasswordViewModel(this.changePasswordRepository)
    : super(ChangePasswordInitial());

  final ChangePasswordRepository changePasswordRepository;

  Future<void> changePassword(ChangePasswordRequest request) async {
    emit(ChangePasswordLoading());
    try {
      await changePasswordRepository.changePassword(request);
      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordError(_cleanError(e)));
    }
  }

  String _cleanError(Object error) {
    final message = error.toString();
    if (message.startsWith('Exception: ')) {
      return message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
