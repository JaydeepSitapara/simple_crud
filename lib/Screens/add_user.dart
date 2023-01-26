import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController userGenderController = TextEditingController();
  TextEditingController userOccupationController = TextEditingController();

  final ref = FirebaseDatabase.instance.ref("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: userPhoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                  ),
                ),
                TextFormField(
                  controller: userAgeController,
                  decoration: InputDecoration(
                    hintText: 'Age',
                  ),
                ),
                TextFormField(
                  controller: userGenderController,
                  decoration: InputDecoration(
                    hintText: 'Gender',
                  ),
                ),
                TextFormField(
                  controller: userOccupationController,
                  decoration: InputDecoration(
                    hintText: 'Occupation',
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    String? id = DateTime.now().microsecondsSinceEpoch.toString();
                    userNameController.text == "" ||
                        userEmailController.text == "" ||
                        userPhoneController.text == "" ||
                        userAgeController.text == "" ||
                        userGenderController.text == "" ||
                        userOccupationController.text == ""
                        ?
                    Fluttertoast.showToast(
                      msg: "Fill the data ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                    ) :

                    ref.child(id).set({
                      'id':id,
                      'userName': userNameController.text.toString(),
                      'userEmail': userEmailController.text.toString(),
                      'userPhone': userPhoneController.text.toString(),
                      'userAge': userAgeController.text.toString(),
                      'userGender': userGenderController.text.toString(),
                      'userOccupation': userOccupationController.text
                          .toString(),
                    }).then((value) {
                      userNameController.text = "";
                      userEmailController.text = "";
                      userPhoneController.text = "";
                      userAgeController.text = "";
                      userGenderController.text = "";
                      userOccupationController.text = "";
                      print('submited');
                      Fluttertoast.showToast(
                        msg: "User Added Successfully ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                      );
                    }).onError((error, stackTrace) {});
                  },
                  child: Text('Add User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
