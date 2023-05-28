import 'package:flutter/material.dart';
// import 'package:medicine_mobile/drawerToPage.dart';

// import 'main.dart';

List<String> linkNames = [
  'О нас',
  'Цены',
  'Сервисы',
  'Новости',
  'Контакты',
];
// List<String> links = [
//   'https://www.google.ru/?client=safari&channel=mac_bm',
//   'https://www.facebook.com',
//   'https://www.youtube.com',
//   'https://vk.com',
//   'https://dzen.ru/'
// ];

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key, required this.stindex});
  final Function stindex;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width - 60,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: List.generate(
              linkNames.length,
              (indexI) => Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   radius: 20,
                      //   backgroundColor: white,
                      //   child: SizedBox(
                      //     width: 24,
                      //     height: 24,
                      //     // child: SvgPicture.asset(listAssetsCategories[index]),
                      //     child: categoryIcon(cm.iconUrl),
                      //   ),
                      // ),
                      title: Text(
                        // listCategoriesHome[index],
                        // cm.title,
                        // style: ts0c_14_500,
                        linkNames[indexI],
                      ),
                      onTap: () {
                        // navigate to home screen
                        // Navigator.pushNamed(
                        //   context,
                        //   // listRoutes[index],
                        //   AppRoute.podcategories_page_route,
                        //   arguments: cm.id,
                        // );

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return DrawerToPage(link: links[3 + index]);
                        //     },
                        //   ),
                        // );
                        Navigator.of(context).pop();
                        widget.stindex(3 + indexI);
                      },
                      trailing: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.arrow_right),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
