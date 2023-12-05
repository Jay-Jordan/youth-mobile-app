import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_fellowship/forms.dart';
import 'navbar.dart';

class UpdateForms extends StatefulWidget {
  const UpdateForms({super.key});
  @override
  State<UpdateForms> createState() => _UpdateFormsState();
}

class _UpdateFormsState extends State<UpdateForms> {
  var searchName = "";

  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gradient1.jpg'), fit: BoxFit.cover,)),
      child: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: TextField(
              onChanged: (value){
                setState(() {
                  searchName = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                filled: true,
                fillColor: Colors.grey.shade900 ,
                hintText: 'Search Existing Member',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                 Icons.search,
                 color: Colors.grey,
                )),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.grey, 
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('members')
              .orderBy('Email')
              .startAt([searchName])
              .endAt(["$searchName\uf8ff"]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator()) ;
            }
            //Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => const RegistrationForm(userId: ['Id'])));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: ClipOval(child: Center(child: Image.asset('assets/youth2.jpg'))),
                      ),
                     title: Text(data['Email']),
                     subtitle: Text(data['Date Of Birth']),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }
}