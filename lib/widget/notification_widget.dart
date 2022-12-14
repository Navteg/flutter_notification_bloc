import 'package:flutter/material.dart';
import 'package:flutter_notification/bloc/notification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/models/exports.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget(
      {Key? key,
      PushNotification? notification,
      PushNotification? PushNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        print('State: $state');
        if (state is NotificationLoaded) {
          return Column(
            children: [
              Text(
                'TITLE: ${state.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'BODY: ${state.body}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              // Text(
              //   'URL: ${state.url}',
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16.0,
              //   ),
              // ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
