import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_fellowship/utils.dart';
import 'navbar.dart';
//import 'package:firebase_storage/firebase_storage.dart';



class RegistrationForm extends StatefulWidget {
  final String fullname;
  final String dob;
  final String sex;
  final String age;
  final String marital;
  final String baptized;
  final String band;
  final String tithecard;
  final String mobile;
  final String email;
  final String id;
  const RegistrationForm(
      {super.key, this.fullname = '',this.dob = '',this.sex = '',this.age = '',this.marital = '',
        this.baptized = '',this.band = '',this.tithecard = '',this.email = '',this.mobile = '',this.id = '', required userId, });
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController maritalController = TextEditingController();
  TextEditingController baptizedController = TextEditingController();
  TextEditingController bandController = TextEditingController();
  TextEditingController tithecardController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState(){
    fullnameController.text = widget.fullname;
    dobController.text = widget.dob;
    sexController.text = widget.sex;
    ageController.text = widget.age;
    maritalController.text = widget.marital;
    baptizedController.text = widget.baptized;
    bandController.text = widget.band;
    tithecardController.text = widget.tithecard;
    mobileController.text = widget.mobile;
    emailController.text = widget.email;
    super.initState();
  }
  @override
  void dispose() {
    fullnameController.dispose();
    dobController.dispose();
    sexController.dispose();
    ageController.dispose();
    maritalController.dispose();
    baptizedController.dispose();
    bandController.dispose();
    tithecardController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }
    Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gradient1.jpg'), fit: BoxFit.cover,)),
      child: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Membership'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Stack(
                    children: [
                      _image != null ?
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(_image!),
                      ),
                    )
                        :
                      const Center(
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/youth2.jpg'),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          TextField(
                            controller: fullnameController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Full Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: dobController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Date Of Birth',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: sexController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Sex',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Age',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: maritalController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Marital Status',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: baptizedController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Are you baptized? / If yes. Where & When?',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: bandController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Present band (if any) / Units',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: tithecardController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Tithe Card No / Last Ordination Rank & Year',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          IntlPhoneField(
                            controller: mobileController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          InkWell(
                            onTap: () async {
                              setState(() {});
                              if (fullnameController.text.isEmpty ||
                                  dobController.text.isEmpty ||
                                  sexController.text.isEmpty ||
                                  ageController.text.isEmpty ||
                                  maritalController.text.isEmpty ||
                                  baptizedController.text.isEmpty ||
                                  bandController.text.isEmpty ||
                                  tithecardController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  mobileController.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Fill all fields')));
                              } else {
                                final dUser = FirebaseFirestore.instance
                                    .collection('members')
                                    .doc(widget.id.isNotEmpty ? widget.id : null);
                                String docID = '';
                                if (widget.id.isNotEmpty) {
                                  docID = widget.id;
                                } else {
                                  docID = dUser.id;
                                }
                                final jsonData = {
                                  'Full Name': fullnameController.text,
                                  'Date Of Birth': dobController.text,
                                  'Sex': sexController.text,
                                  'Age': int.parse(ageController.text),
                                  'Marital': maritalController.text,
                                  'Baptized': baptizedController.text,
                                  'Band': bandController.text,
                                  'Tithe Card': tithecardController.text,
                                  'Email': emailController.text,
                                  'Phone': mobileController.text,
                                  'id': docID
                                };
                                showProgressIndicator = true;
                                if (widget.id.isEmpty) {
                                  await dUser.set(jsonData).then((value){
                                    fullnameController.text = '';
                                    dobController.text = '';
                                    sexController.text = '';
                                    ageController.text = '';
                                    maritalController.text = '';
                                    baptizedController.text = '';
                                    bandController.text = '';
                                    tithecardController.text = '';
                                    emailController.text = '';
                                    mobileController.text = '';
                                    showProgressIndicator = false;
                                    setState(() {});
                                  });
                                } else {
                                  await dUser.update(jsonData).then((value){
                                    ageController.text = '';
                                    maritalController.text = '';
                                    baptizedController.text = '';
                                    bandController.text = '';
                                    tithecardController.text = '';
                                    emailController.text = '';
                                    mobileController.text = '';
                                    showProgressIndicator = false;
                                    setState(() {});
                                  });
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12,
                                  horizontal: 25),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                  "Submit",
                                  style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(height: 25,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
