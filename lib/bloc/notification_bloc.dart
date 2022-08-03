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
    // if (initialMessage != null) {
    //   print('Inside _notificationLoaded');

    if (event.notification.body != null) {
      print('Inside _notificationLoaded');
      emit(NotificationLoaded(
        title: event.notification.title!,
        body: event.notification.body!,
        dataTitle: event.notification.title!,
        dataBody: event.notification.body!,
        // url: event.notification.url,
      ));
    } else {
      print('Inside else _notificationLoaded');
      emit(NotificationInitial());
    }

    // } else {
    //   print('Inside else _notificationLoaded');
    //   print(event.toString());
    //   emit(NotificationInitial());
    // }
  }
}
