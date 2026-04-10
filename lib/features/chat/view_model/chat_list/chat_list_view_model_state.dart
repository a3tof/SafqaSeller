import 'package:equatable/equatable.dart';
import 'package:safqaseller/features/chat/model/models/chat_models.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object?> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListSuccess extends ChatListState {
  final List<ConversationModel> conversations;

  const ChatListSuccess({required this.conversations});

  @override
  List<Object?> get props => [conversations];
}

class ChatListFailure extends ChatListState {
  final String message;

  const ChatListFailure(this.message);

  @override
  List<Object?> get props => [message];
}
