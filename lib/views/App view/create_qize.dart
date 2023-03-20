// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateprep/services/database.dart';
import 'package:gateprep/views/App%20view/addquestion.dart';
import 'package:gateprep/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;

  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgurl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestion(
                        quizId: quizId,
                      )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  TextFormField(
                    cursorColor: Colors.amber,
                    validator: (val) =>
                        val!.isEmpty ? "Enter image url " : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber), //<-- SEE HERE
                      ),
                      hoverColor: Colors.amber,
                      hintText: "Quize Image Url",
                    ),
                    onChanged: (val) {
                      quizImageUrl = val;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    cursorColor: Colors.amber,
                    validator: (val) =>
                        val!.isEmpty ? "Enter Quiz Title  " : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber), //<-- SEE HERE
                      ),
                      hintText: "Quize Title",
                    ),
                    onChanged: (val) {
                      quizTitle = val;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    cursorColor: Colors.amber,
                    validator: (val) =>
                        val!.isEmpty ? "Enter Quiz Description " : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber), //<-- SEE HERE
                      ),
                      hintText: "Quize Description",
                    ),
                    onChanged: (val) {
                      quizDescription = val;
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child:
                          amberButton(context: context, lable: "Create Quiz")),
                  SizedBox(
                    height: 70,
                  )
                ]),
              ),
            ),
    );
  }
}
