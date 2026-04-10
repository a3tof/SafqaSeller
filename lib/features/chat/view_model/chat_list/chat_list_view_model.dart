import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/chat/model/repositories/chat_repository.dart';
import 'package:safqaseller/features/chat/view_model/chat_list/chat_list_view_model_state.dart';

class ChatListViewModel extends Cubit<ChatListState> {
  final ChatRepository chatRepository;

  ChatListViewModel(this.chatRepository) : super(ChatListInitial());

  Future<void> loadConversations() async {
    emit(ChatListLoading());
    try {
      final conversations = await chatRepository.getConversations();
      emit(ChatListSuccess(conversations: conversations));
    } catch (error) {
      emit(ChatListFailure(_clean(error)));
    }
  }

  Future<void> refresh() => loadConversations();

  String _clean(Object error) {
    var message = error.toString();
    if (message.startsWith('Exception: ')) {
      message = message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
