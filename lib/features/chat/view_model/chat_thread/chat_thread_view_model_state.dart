import 'package:equatable/equatable.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';

abstract class ChatThreadState extends Equatable {
  const ChatThreadState();

  @override
  List<Object?> get props => [];
}

class ChatThreadInitial extends ChatThreadState {}

class ChatThreadLoading extends ChatThreadState {}

class ChatThreadSuccess extends ChatThreadState {
  final int conversationId;
  final List<MessageModel> messages;
  final bool isSending;
  final String? sendErrorMessage;

  const ChatThreadSuccess({
    required this.conversationId,
    required this.messages,
    this.isSending = false,
    this.sendErrorMessage,
  });

  ChatThreadSuccess copyWith({
    int? conversationId,
    List<MessageModel>? messages,
    bool? isSending,
    Object? sendErrorMessage = _sentinel,
  }) {
    return ChatThreadSuccess(
      conversationId: conversationId ?? this.conversationId,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      sendErrorMessage: identical(sendErrorMessage, _sentinel)
          ? this.sendErrorMessage
          : sendErrorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    conversationId,
    messages,
    isSending,
    sendErrorMessage,
  ];
}

class ChatThreadFailure extends ChatThreadState {
  final String message;

  const ChatThreadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

const Object _sentinel = Object();
