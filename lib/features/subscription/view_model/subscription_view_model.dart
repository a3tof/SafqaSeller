import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/subscription/model/repositories/subscription_repository.dart';
import 'package:safqaseller/features/subscription/view_model/subscription_view_model_state.dart';

class SubscriptionViewModel extends Cubit<SubscriptionState> {
  SubscriptionViewModel(this.subscriptionRepository)
    : super(
        SubscriptionInitial(
          activePlanId: subscriptionRepository.getActivePlanId(),
        ),
      );

  final SubscriptionRepository subscriptionRepository;

  Future<void> upgrade({required int upgradeType}) async {
    final planId = upgradeType.toString();
    emit(
      SubscriptionLoading(
        planId,
        activePlanId: subscriptionRepository.getActivePlanId(),
      ),
    );
    try {
      final savedPlanId = await subscriptionRepository.upgrade(
        upgradeType: upgradeType,
      );
      emit(SubscriptionSuccess(savedPlanId));
    } catch (e) {
      emit(
        SubscriptionError(
          _clean(e),
          planId,
          activePlanId: subscriptionRepository.getActivePlanId(),
        ),
      );
    }
  }

  String _clean(Object error) {
    var message = error.toString();
    if (message.startsWith('Exception: ')) {
      message = message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
