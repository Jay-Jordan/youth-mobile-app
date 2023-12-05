import 'package:flutter/material.dart';
import 'package:youth_fellowship/announcement.dart';
import 'package:youth_fellowship/forms.dart';
import 'package:youth_fellowship/updateforms.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState((){
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Home(),
    const RegistrationForm(userId: null,),
    const Announcement(),
     const UpdateForms(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items:const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_add,
                color: Colors.grey,),
              label: 'Members'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.speaker_notes_outlined,
                color: Colors.grey,),
              label: 'Announcement'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
                color: Colors.grey,),
              label: 'Upcoming Programmes'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomSheet(context);
        },
        backgroundColor: Colors.white,
        elevation: 0,
        mini: true,
        child: const Icon(
            Icons.more_horiz_rounded,
            color: Colors.grey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _bottomSheet(context){
    showModalBottomSheet(context: context,
        backgroundColor: Colors.blue,
        builder: (BuildContext c){
      return const Wrap(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Center(
                  child: Text('More From US', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                ),
              ),
              SizedBox(height: 9),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.church_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text('Special Prayers',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                ),
              ),
              SizedBox(height: 5,),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.church_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text('Hymnals',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                ),
              ),
              SizedBox(height: 5,),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.church_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text('Special Events',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                ),
              ),
            ],
          ),
        ],
      );
    }
    );
  }
}
