import 'package:flutter/material.dart';

List<String> linkNames = [
  'О нас',
  'Цены',
  'Сервисы',
  'Новости',
  'Контакты',
];

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
                title: Text(
                  linkNames[indexI],
                ),
                onTap: () {
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
            ),
          ),
        ),
      ),
    );
  }
}
