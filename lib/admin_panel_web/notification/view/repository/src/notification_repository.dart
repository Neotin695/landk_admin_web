import 'package:dio/dio.dart';

import '../../../../../core/constances/logic_const.dart';

abstract class _NotificationRepository {
  Future<bool> sendNotify(String topic, String body, String title);
}

class NotificationRepository implements _NotificationRepository{
  @override
  Future<bool> sendNotify(String topic, String body, String title) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: LogicConst.baseUrlFirebase,
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${LogicConst.serverKey}',
        },
      ),
    );

    final response = await dio.post(
      dio.options.baseUrl,
      data: <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
        'message': {
          'topic': topic,
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'android_channel_id': 'dbfood',
          },
        }
      },
    );
    return response.statusCode == 200;
  }
}
