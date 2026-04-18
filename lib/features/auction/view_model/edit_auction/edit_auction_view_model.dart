import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/auction/model/models/auction_detail_model.dart';
import 'package:safqaseller/features/auction/model/repositories/auction_repository.dart';
import 'package:safqaseller/features/auction/view_model/edit_auction/edit_auction_view_model_state.dart';

class EditAuctionViewModel extends Cubit<EditAuctionViewModelState> {
  final AuctionRepository auctionRepository;

  EditAuctionViewModel(this.auctionRepository) : super(EditAuctionInitial());

  AuctionDetailModel? detail;

  Future<void> loadAuction(int id) async {
    emit(EditAuctionLoading());
    try {
      final loadedDetail = await auctionRepository.viewAuction(id);
      detail = loadedDetail;
      emit(EditAuctionLoaded(loadedDetail));
    } catch (e) {
      emit(EditAuctionFailure(_clean(e)));
    }
  }

  Future<void> saveAuction({
    required int id,
    required EditAuctionRequestModel request,
  }) async {
    final currentDetail = detail;
    if (currentDetail != null) {
      emit(EditAuctionSaving(currentDetail));
    } else {
      emit(EditAuctionLoading());
    }

    try {
      await auctionRepository.editAuction(id: id, request: request);
      emit(EditAuctionSaveSuccess());
    } catch (e) {
      if (currentDetail != null) {
        emit(EditAuctionLoaded(currentDetail));
      }
      emit(EditAuctionFailure(_clean(e)));
    }
  }

  String _clean(Object error) {
    final message = error.toString();
    if (message.startsWith('Exception: ')) {
      return message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
