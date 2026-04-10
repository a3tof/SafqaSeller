import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';
import 'package:safqaseller/features/chat/model/repositories/chat_repository.dart';
import 'package:safqaseller/features/chat/view_model/chat_thread/chat_thread_view_model_state.dart';

class ChatThreadViewModel extends Cubit<ChatThreadState> {
  final ChatRepository chatRepository;

  ChatThreadViewModel(this.chatRepository) : super(ChatThreadInitial());

  Future<void> loadMessages(int conversationId) async {
    emit(ChatThreadLoading());
    try {
      final messages = await chatRepository.getMessages(conversationId);
      messages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
      emit(
        ChatThreadSuccess(conversationId: conversationId, messages: messages),
      );
    } catch (error) {
      emit(ChatThreadFailure(_clean(error)));
    }
  }

  Future<void> refresh() async {
    final currentState = state;
    if (currentState is! ChatThreadSuccess) return;
    await loadMessages(currentState.conversationId);
  }

  Future<void> sendMessage(String content) async {
    final currentState = state;
    if (currentState is! ChatThreadSuccess || content.trim().isEmpty) return;

    final trimmedContent = content.trim();
    final optimisticMessage = MessageModel(
      id: -DateTime.now().microsecondsSinceEpoch,
      conversationId: currentState.conversationId,
      content: trimmedContent,
      sentAt: DateTime.now(),
      isMine: true,
      isPending: true,
    );

    final updatedMessages = [optimisticMessage, ...currentState.messages];
    emit(
      currentState.copyWith(
        messages: updatedMessages,
        isSending: true,
        sendErrorMessage: null,
      ),
    );

    try {
      final sentMessage = await chatRepository.sendMessage(
        conversationId: currentState.conversationId,
        content: trimmedContent,
      );

      final resolvedMessages = updatedMessages
          .map(
            (message) => message.id == optimisticMessage.id
                ? sentMessage.copyWith(
                    conversationId: currentState.conversationId,
                    content: sentMessage.content.isEmpty
                        ? trimmedContent
                        : sentMessage.content,
                    sentAt: sentMessage.sentAt,
                    isMine: true,
                    isPending: false,
                  )
                : message,
          )
          .toList();

      emit(
        currentState.copyWith(
          messages: resolvedMessages,
          isSending: false,
          sendErrorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        currentState.copyWith(
          messages: currentState.messages,
          isSending: false,
          sendErrorMessage: _clean(error),
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
