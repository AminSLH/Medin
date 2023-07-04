import 'package:flutter/material.dart';
import 'package:medin/models/content.model.dart';
import 'package:medin/view_models/content.viewmodel.dart';
import 'package:medin/views/course.view.dart';
import 'package:medin/views/equipment.view.dart';
import 'package:medin/views/faq.view.dart';
import 'package:medin/views/suggest_course.view.dart';
import 'package:medin/views/your_courses.view.dart';
import 'package:provider/provider.dart';
import 'package:medin/views/suggest.view.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    _contentViewModel = Provider.of<ContentViewModel>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent;
    switch (_currentPage) {
      case ContentPage.courses:
        pageContent = const CourseView();
        break;
      case ContentPage.equipment:
        pageContent = const EquipmentView();
        break;
      case ContentPage.suggest:
        pageContent = const SuggestView();
        // pageContent = CourseView();
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
          //color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Amine'),
                accountEmail:
                    Text(FirebaseAuth.instance.currentUser!.email! ?? 'Guest'),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/2.jpg',
                  ),
                ),
                // decoration: BoxDecoration(
                //     color: Theme.of(context).colorScheme.secondary),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profil'),
                onTap: () {
                  // naviguer vers l'écran de profil de l'utilisateur
                },
              ),
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('Vos formations'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const YourCoursesView()),
                  );
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
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Aide et FAQ'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FaqView();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: const Text('Déconnexion'),
                onTap: _contentViewModel.logout,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: pageContent,
      ),
      floatingActionButton: _currentPage == ContentPage.courses
          ? FloatingActionButton(
              onPressed: () {
                //push navigator to SuggestCourseView()
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SuggestCourseView();
                }));
              },
              child: const Icon(Icons.add),
              // backgroundColor: Colors.blue,
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: [
          ContentPage.courses,
          ContentPage.equipment,
          ContentPage.suggest
        ].indexOf(_currentPage),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.group),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.build),
            label: 'Equipments',
          ),
          NavigationDestination(
            icon: Icon(Icons.lightbulb),
            label: 'Suggestions',
          ),
        ],
        onDestinationSelected: (index) {
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
      ),
    );
  }
}
