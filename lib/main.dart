import 'dart:io';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:medicine_mobile/config.dart';
import 'package:medicine_mobile/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:medicine_mobile/notification_service.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/tzdata.dart' as tz;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

int currentIndex = 0;
int currentIndexBottom = 0;

List<String> links = [
  '',
  'our-doctors',
  'profile',
  'about',
  'prices',
  'services',
  'news',
  'contact',
];

List<WebViewController> controllers = List.generate(links.length, (index) {
  return WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
      Uri.parse(baseUrl + links[index]),
    );
});

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  initializeDateFormatting('ru', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Clinic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitializationSettings = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    Future<void> fetchDay() async {
      try {
        final response =
            await http.get(Uri.parse('http://127.0.0.1/api/time/1'));
        if (response.statusCode == 200) {
          String day = jsonDecode(response.body)['day'];
          DateTime dateTime = DateTime.parse(day);
          String formattedDate =
              DateFormat('d MMMM yyyy HH:mm', 'ru').format(dateTime);
          Noti.showBigTextNotification(
            title: 'Dental Clinic',
            body: 'Не забудьте запись в $formattedDate',
            fln: flutterLocalNotificationsPlugin,
          );
          Noti.showScheduleNotification(
            title: 'ReadIT',
            body: 'У вас запись в $formattedDate',
            fln: flutterLocalNotificationsPlugin,
          );
        } else {
          throw Exception('Failed to load API data');
        }
      } catch (e) {
        throw Exception('Failed to load API data');
      }
    }

    fetchDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawerEnableOpenDragGesture: false,
      drawer: DrawerPage(
        stindex: (int index) {
          setState(() {
            currentIndex = index;
            currentIndexBottom = index > 2 ? currentIndexBottom : index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: List.generate(
          links.length,
          (index) => WebViewWidget(
            controller: controllers[index],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 7,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: BottomNavigationBar(
            currentIndex: currentIndexBottom,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: (value) {
              setState(() {
                currentIndex = value;
                currentIndexBottom = value;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главный',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Докторы',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Профиль',
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            print('TAPPED DRAWER');
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
          color: Colors.white,
        );
      }),
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      title: Text('Dental'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      elevation: 7,
      shadowColor: Colors.grey.shade500,
    );
  }
}
