// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import 'config.dart';

// class DrawerToPage extends StatefulWidget {
//   const DrawerToPage({super.key, required this.link});
//   final String link;

//   @override
//   State<DrawerToPage> createState() => _DrawerToPageState();
// }

// WebViewController _controller = WebViewController()
//   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//   ..setBackgroundColor(const Color(0x00000000))
//   ..setNavigationDelegate(
//     NavigationDelegate(
//       onProgress: (int progress) {
//         // Update loading bar.
//       },
//       onPageStarted: (String url) {},
//       onPageFinished: (String url) {},
//       onWebResourceError: (WebResourceError error) {},
//       onNavigationRequest: (NavigationRequest request) {
//         return NavigationDecision.navigate;
//       },
//     ),
//   );
// // ..loadRequest(Uri.parse(links[2]));

// class _DrawerToPageState extends State<DrawerToPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller.loadRequest(Uri.parse(baseUrl + widget.link));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: Builder(builder: (context) {
//       //     return IconButton(
//       //       onPressed: () {
//       //         print('TAPPED DRAWER');
//       //         Scaffold.of(context).openDrawer();
//       //       },
//       //       icon: Icon(Icons.menu),
//       //       color: Colors.white,
//       //     );
//       //   }),
//       //   toolbarHeight: 60,
//       //   automaticallyImplyLeading: false,
//       //   title: Text('Dental'),
//       //   shape: const RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//       //   ),
//       //   elevation: 7,
//       //   shadowColor: Colors.grey.shade500,
//       // ),
//       // drawerEnableOpenDragGesture: false,
//       // body: Center(
//       //   child: WebViewWidget(
//       //     controller: controllers[currentIndex],
//       //   ),
//       // ),
//       body: SafeArea(
//         child: WebViewWidget(
//           controller: _controller,
//         ),
//       ),
//     );
//   }
// }
