import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging fcm;

void initFcm() {
  if (fcm == null) {
    fcm = FirebaseMessaging();
  }

  fcm.getToken().then((token) {
    print("\n******\nFirebase Token $token\n******\n");
  });

  // Você pode enviar notificação para um tópico específico
  // (perfis, tipo de clientes, categorias, etc) lá no client do firebase
  fcm.subscribeToTopic("donos de dogs");

  fcm.configure(
    // Com o app aberto recebendo a notificação
    onMessage: (Map<String, dynamic> message) async {
      print('\n\n\n*** on message $message');
    },
    // Com o app em background recebendo a notificação
    onResume: (Map<String, dynamic> message) async {
      print('\n\n\n*** on resume $message');
    },
    // Com o app fechado recebendo a notificação
    onLaunch: (Map<String, dynamic> message) async {
      print('\n\n\n*** on launch $message');
    },
  );

  if (Platform.isIOS) {
    fcm.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    fcm.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("iOS Push Settings: [$settings]");
    });
  }
}