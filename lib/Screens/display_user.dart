import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DisplayUser extends StatefulWidget {
  const DisplayUser({Key? key}) : super(key: key);

  @override
  _DisplayUserState createState() => _DisplayUserState();
}

class _DisplayUserState extends State<DisplayUser> {
  TextEditingController uName = TextEditingController();
  TextEditingController uEmail = TextEditingController();
  TextEditingController uPhone = TextEditingController();
  TextEditingController uAge = TextEditingController();
  TextEditingController uGender = TextEditingController();
  TextEditingController uOccupation = TextEditingController();

  final ref = FirebaseDatabase.instance.ref('Users');

  //bool dataAvail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display User'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: ((context, snapshot, animation, index) {
                  //dataAvail = false;
                  return Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.child('userName').value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.child('userEmail').value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.child('userPhone').value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.child('userAge').value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.child('userGender').value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot
                                    .child('userOccupation')
                                    .value
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              uName.text = snapshot.child('userName').value.toString();
                              uEmail.text = snapshot.child('userEmail').value.toString();
                              uPhone.text = snapshot.child('userPhone').value.toString();
                              uAge.text = snapshot.child('userAge').value.toString();
                              uGender.text = snapshot.child('userGender').value.toString();
                              uOccupation.text = snapshot.child('userOccupation').value.toString();
                              print(snapshot.child('id').value.toString());
                              updateUser(snapshot.child('id').value.toString());
                            },
                            child: Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  void updateUser(String id) {
    print('dialog');
    showDialog<void>(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Dialog(
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: uName,
                      decoration: InputDecoration(helperText: "Name"),
                    ),
                    TextFormField(
                      controller: uEmail,
                      decoration: InputDecoration(helperText: "Email"),
                    ),
                    TextFormField(
                      controller: uPhone,
                      decoration: InputDecoration(helperText: "Phone"),
                    ),
                    TextFormField(
                      controller: uAge,
                      decoration: InputDecoration(helperText: "Age"),
                    ),
                    TextFormField(
                      controller: uGender,
                      decoration: InputDecoration(helperText: "Gender"),
                    ),
                    TextFormField(
                      controller: uOccupation,
                      decoration: InputDecoration(helperText: "Occupation"),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              print(id);
                              ref
                                  .child(id)
                                  .update({
                                    'userName': uName.text.toString(),
                                    'userEmail': uEmail.text.toString(),
                                    'userPhone': uPhone.text.toString(),
                                    'userAge': uAge.text.toString(),
                                    'userGender': uGender.text.toString(),
                                    'userOccupation':
                                        uOccupation.text.toString(),
                                  })
                                  .then((value) => {
                                        Fluttertoast.showToast(
                                          msg: "Updated",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.SNACKBAR,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                        )
                                      })
                                  .onError((error, stackTrace) => {
                                        Fluttertoast.showToast(
                                          msg: error.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.SNACKBAR,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                        )
                                      });
                              Navigator.pop(context);
                            },
                            child: Text('Edit')),
                        ElevatedButton(
                            onPressed: () {
                              ref.child(id).remove().then((value) => {
                                Fluttertoast.showToast(
                                  msg: "Deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                )
                              }).onError((error, stackTrace) => {
                                Fluttertoast.showToast(
                                  msg: error.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                )
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Delete')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
