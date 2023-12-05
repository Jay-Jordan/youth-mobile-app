import  'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youth_fellowship/navbar.dart';
import 'package:youth_fellowship/updateforms.dart';
import 'announcement.dart';
import 'package:youth_fellowship/forms.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List imageList = [
    {"id": 1, "image_path": 'assets/ads 1.png'},
    {"id": 1, "image_path": 'assets/ads 2.jpg'},
    {"id": 1, "image_path": 'assets/ads 3.png'},
    {"id": 1, "image_path": 'assets/ads 4.jpg'},
    {"id": 1, "image_path": 'assets/ads 5.webp'}
  ];

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      title: "Are You A New Or Existing Member?",
      type: QuickAlertType.confirm,
      confirmBtnText: "New Member",
      onConfirmBtnTap: () =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  const RegistrationForm(userId: null,))),
      cancelBtnText: "Existing Member",
      onCancelBtnTap: () =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>   const UpdateForms())),
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          elevation: 0,
          title: const Text('HOME'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
                onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    children: [
                      SizedBox(
                        width: 1000,
                        height: 200,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                color: Colors.black,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: CarouselSlider(
                                    items: imageList
                                        .map(
                                          (item) =>
                                          Image.asset(
                                            item['image_path'],
                                            fit: BoxFit.cover,
                                            width: double.maxFinite,
                                          ),
                                    )
                                        .toList(),
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      scrollPhysics: const BouncingScrollPhysics(),
                                      autoPlay: true,
                                      aspectRatio: 1,
                                      viewportFraction: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showAlert();
                        },
                        child: SizedBox(
                          width: 1000,
                          height: 200,
                          child: Card(
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        "assets/person.gif", width: 70.0),
                                    const SizedBox(height: 15.0),
                                    const Text("Membership", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL("https://www.youtube.com/@YOUTHFELLOWSHIPAYONIOSURULERE/streams");
                        },
                        child: SizedBox(
                          width: 1000,
                          height: 180,
                          child: Card(
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        "assets/video1.gif", width: 70.0),
                                    const SizedBox(height: 15.0),
                                    const Text("Watch Live", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const Announcement()));
                        },
                        child: SizedBox(
                          width: 1000,
                          height: 200,
                          child: Card(
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        "assets/document1.gif", width: 70.0),
                                    const SizedBox(height: 15.0),
                                    const Text("Announcements", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
