import 'package:flutter/material.dart';
import 'package:my_crew/widgets/header.dart';
import 'package:my_crew/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
    createUser();
  }

  createUser() {
    usersRef
        .document("1AAAA@DDDD")
        .setData({"username": "sagar", "postsCount": 1, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.document("1AAAA@DDDD").get();
    if (doc.exists) {
      doc.reference.updateData(
          {"username": "vidyasagar", "postsCount": 1, "isAdmin": false});
    }
  }

  deleteUser() async {
    final doc = await usersRef.document("1AAAA@DDDD").get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents
              .map((data) => Text(data["username"]))
              .toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
        stream: usersRef.snapshots(),
      ),
    );
  }
}
