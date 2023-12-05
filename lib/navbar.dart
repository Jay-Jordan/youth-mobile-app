import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youth_fellowship/home.dart';
import 'announcement.dart';
import 'forms.dart';


class NavBar  extends StatelessWidget {

  const NavBar ({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              accountName: const Text('Welcome Back', style: TextStyle(color: Colors.black),),
              accountEmail:  Text(user.email!,
                style: const TextStyle(color: Colors.black),),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Center(child: Image.asset('assets/youth2.jpg'))),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                  //image: DecorationImage(image: AssetImage('assets/youth.png'), fit: BoxFit.cover)
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Announcement'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Announcement()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.church_rounded),
            title: const Text('Membership Form'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistrationForm(userId: null,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_front),
            title: const Text('Watch Live'),
            onTap: (){
              _launchURL("https://m.youtube.com/@YOUTHFELLOWSHIPAYONIOSURULERE/streams");
            },
          ),
          const SizedBox(height: 600,),
          ListTile(
           leading: const Icon(Icons.arrow_back),
            title: const Text('Log Out'),
           onTap: () => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
    );

  }
}
