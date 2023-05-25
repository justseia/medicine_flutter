// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicine_mobile/config.dart';
import 'package:medicine_mobile/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
// List<String> links = [
//   'https://www.facebook.com',
//   'https://www.google.ru/?client=safari&channel=mac_bm',
//   'https://www.youtube.com',
//   'https://vc.ru',
//   'https://www.instagram.com',
//   'https://kaspi.kz',
//   'https://vk.com',
//   'https://dzen.ru/',
// ];
List<String> links = [
  '',
  'our-doctors',
  'login',
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
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(baseUrl + links[index]));
  ;
});

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
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
      // body: Center(
      //   child: WebViewWidget(
      //     controller: controllers[currentIndex],
      //   ),
      // ),

      body: IndexedStack(
        index: currentIndex,
        // children: [
        //   WebViewWidget(
        //     controller: controllers[0],
        //   ),
        //   WebViewWidget(
        //     controller: controllers[1],
        //   ),
        //   WebViewWidget(
        //     controller: controllers[2],
        //   ),
        // ],
        children: List.generate(
          links.length,
          (index) => WebViewWidget(
            controller: controllers[index],
          ),
        ),
      ),

      // body: WebViewWidget(
      //   controller: controllers[currentIndex],
      // ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), //color of shadow
              spreadRadius: 7, //spread radius
              blurRadius: 10, // blur radius
              offset: Offset(0, 2), // changes position of shadow
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
