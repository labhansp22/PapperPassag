// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateprep/services/auth.dart';
import 'package:gateprep/services/database.dart';
import 'package:gateprep/views/App%20view/create_qize.dart';
import 'package:gateprep/views/App%20view/play_quiuz.dart';

import '../../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  Stream? quizStream;
  DatabaseService databaseServices = new DatabaseService();

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
          stream: quizStream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return QuizTile(
                        imgUrl: snapshot.data.docs[index].data()["quizImgurl"],
                        title: snapshot.data.docs[index].data()["quizTitle"],
                        desc: snapshot.data.docs[index].data()["quizDesc"],
                        quizId: snapshot.data.docs[index].data()["quizId"],
                      );
                    });
          }),
    );
  }

  @override
  void initState() {
    databaseServices.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.follow_the_signs_sharp),
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black45,
            ),
            label: Text("Logout"),
          )
        ],
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(padding: EdgeInsets.only(top: 13), child: quizList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black54,
        ),
        backgroundColor: Colors.amber,
        elevation: 5,
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title, desc, quizId;

  const QuizTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.desc,
      required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayQuiz(
                quizId: quizId,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 9),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
