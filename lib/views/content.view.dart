import 'package:flutter/material.dart';
import 'package:medin/models/content.model.dart';
import 'package:medin/view_models/content.viewmodel.dart';
import 'package:medin/views/course.view.dart';
import 'package:medin/views/equipment.view.dart';
import 'package:provider/provider.dart';
import 'package:medin/views/suggest.view.dart';

class ContentView extends StatefulWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late ContentViewModel _contentViewModel;
  ContentPage _currentPage = ContentPage.courses;

  void _changePage(ContentPage page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    this._contentViewModel =
        Provider.of<ContentViewModel>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent;
    switch (_currentPage) {
      case ContentPage.courses:
        pageContent = CourseView();
        break;
      case ContentPage.equipment:
        pageContent = EquipmentView();
        break;
      case ContentPage.suggest:
        //pageContent = SuggestView();
        pageContent = CourseView();
        break;
      default:
        pageContent = const Center(
          child: Text('Invalid page'),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDIN'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'),
                accountEmail: Text('johndoe@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/2.jpg',
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profil'),
                onTap: () {
                  // naviguer vers l'écran de profil de l'utilisateur
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book),
                title: Text('Vos formations'),
                onTap: () {
                  //TODO: add archive page

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ArchivePage()),
                  // );
                },
              ),
              /*
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Paramètres'),
          onTap: () {
            // naviguer vers l'écran de paramètres de l'application
          },
          
        ),*/
              Divider(),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Aide et commentaires'),
                onTap: () {
                  // naviguer vers l'écran d'aide et de commentaires
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Déconnexion'),
                onTap: _contentViewModel.logout,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: pageContent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: [
          ContentPage.courses,
          ContentPage.equipment,
          ContentPage.suggest
        ].indexOf(_currentPage),
        onTap: (index) {
          switch (index) {
            case 0:
              _changePage(ContentPage.courses);
              break;
            case 1:
              _changePage(ContentPage.equipment);
              break;
            case 2:
              _changePage(ContentPage.suggest);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Courses',
            icon: Icon(Icons.group),
          ),
          BottomNavigationBarItem(
            label: 'Equipments',
            icon: Icon(Icons.build),
          ),
          BottomNavigationBarItem(
            label: 'Suggestions',
            icon: Icon(Icons.lightbulb),
          ),
        ],
      ),
    );
  }
}
