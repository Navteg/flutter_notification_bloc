import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification/models/exports.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationReceivedEvent>(_notificationLoaded);
  }

  void _notificationLoaded(
      NotificationReceivedEvent event, Emitter<NotificationState> emit) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      emit(NotificationLoaded(
        title: initialMessage.data['title'],
        body: initialMessage.data['body'],
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
        url: initialMessage.data['url'],
      ));
    } else {
      emit(NotificationInitial());
    }
  }
}
