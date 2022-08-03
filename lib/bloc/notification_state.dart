part of 'notification_bloc.dart';

@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final String title;
  final String body;
  final String dataTitle;
  final String dataBody;
  final String url;

  const NotificationLoaded(
      {required this.title,
      required this.body,
      required this.dataTitle,
      required this.dataBody,
      required this.url});

  @override
  List<Object> get props => [title, body, dataTitle, dataBody, url];
}


// nullsafety