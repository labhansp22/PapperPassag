// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateprep/services/database.dart';
import 'package:gateprep/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  const AddQuestion({super.key, required this.quizId});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  late String question, option1, option2, option3, option4;
  bool _isLoading = false;

  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };
      await databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          _isLoading = false;
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(children: [
                    TextFormField(
                      cursorColor: Colors.amber,
                      validator: (val) =>
                          val!.isEmpty ? "Enter question " : null,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        // ignore: prefer_const_constructors
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber), //<-- SEE HERE
                        ),
                        hoverColor: Colors.amber,
                        hintText: "Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option1  " : null,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber), //<-- SEE HERE
                        ),
                        hintText: "Option1 (Correct Answer)",
                      ),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option2 " : null,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        // ignore: prefer_const_constructors
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber), //<-- SEE HERE
                        ),
                        hoverColor: Colors.amber,
                        hintText: "Option2",
                      ),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option3  " : null,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber), //<-- SEE HERE
                        ),
                        hintText: "Option3",
                      ),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option4 " : null,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber), //<-- SEE HERE
                        ),
                        hoverColor: Colors.amber,
                        hintText: "Option4",
                      ),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: amberButton(
                                context: context,
                                lable: "Submit",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 -
                                        36)),
                        SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                            onTap: () {
                              uploadQuestionData();
                            },
                            child: amberButton(
                                context: context,
                                lable: "Add Question",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 -
                                        36)),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
