import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_notification/bloc/notification_bloc.dart';
import 'package:flutter_notification/models/push_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Test cases for Notification',
    (() {
      blocTest<NotificationBloc, NotificationState>(
        'Testing of Bloc',
        build: () => NotificationBloc()..add(CheckIntitialMessage()),
        act: (bloc) => bloc.add(CheckIntitialMessage()),
        verify: (bloc) {
          expect(bloc.state, NotificationInitial());
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'Checking for NotificationLoaded',
        build: () => NotificationBloc()
          ..add(NotificationReceivedEvent(notification: PushNotification())),
        act: (bloc) => bloc.add(NotificationReceivedEvent(
            notification: PushNotification(
                title: 'Test Title',
                body: 'Test Body',
                dataTitle: 'Test Title',
                dataBody: 'Test Body'))),
        verify: (bloc) {
          expect(
            bloc.state,
            const NotificationLoaded(
                title: 'Test Title',
                body: 'Test Body',
                dataTitle: 'Test Title',
                dataBody: 'Test Body'),
          );
        },
      );
    }),
  );
}
