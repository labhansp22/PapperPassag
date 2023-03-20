// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateprep/models/question_model.dart';
import 'package:gateprep/views/App%20view/result.dart';
import 'package:gateprep/widgets/quiz_play_widgets.dart';

import '../../services/database.dart';
import '../../widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  const PlayQuiz({super.key, required this.quizId});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseServices = new DatabaseService();
  QuerySnapshot? questionsSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.get("question");
    List<String> options = [
      questionSnapshot.get("option1"),
      questionSnapshot.get("option2"),
      questionSnapshot.get("option3"),
      questionSnapshot.get("option4"),
    ];
    questionModel.correctOption = options[0];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];

    questionModel.answered = false;
    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseServices.getQuestionData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot!.docs.length;
      print("$total this is total");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        child: Column(children: [
          questionsSnapshot == null
              ? Container(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: questionsSnapshot!.size,
                  itemBuilder: (context, index) {
                    return QuizPlayTile(
                      questionModel: getQuestionModelFromDatasnapshot(
                          questionsSnapshot!.docs[index]),
                      index: index,
                    );
                  },
                )
        ]
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.check_box),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Results(correct: _correct, incorrect: _incorrect, total: total)));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  const QuizPlayTile(
      {super.key, required this.questionModel, required this.index});

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Q${widget.index+1}. ${widget.questionModel.question.toString()}",
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                widget.questionModel.answered == false) {
              if (widget.questionModel.option1.toString() ==
                  widget.questionModel.correctOption.toString()) {
                setState(() {
                  optionSelected = widget.questionModel.option1.toString();
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option1.toString();
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
              option: "A",
              description: widget.questionModel.option1.toString(),
              correctAnswer: widget.questionModel.correctOption.toString(),
              optionSelected: optionSelected),
        ),
        SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                widget.questionModel.answered == false) {
              if (widget.questionModel.option2.toString() ==
                  widget.questionModel.correctOption.toString()) {
                setState(() {
                  optionSelected = widget.questionModel.option2.toString();
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option2.toString();
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
              option: "B",
              description: widget.questionModel.option2.toString(),
              correctAnswer: widget.questionModel.correctOption.toString(),
              optionSelected: optionSelected),
        ),
        SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                widget.questionModel.answered == false) {
              if (widget.questionModel.option3.toString() ==
                  widget.questionModel.correctOption.toString()) {
                setState(() {
                  optionSelected = widget.questionModel.option3.toString();
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option3.toString();
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
              option: "C",
              description: widget.questionModel.option3.toString(),
              correctAnswer: widget.questionModel.correctOption.toString(),
              optionSelected: optionSelected),
        ),
        SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                widget.questionModel.answered == false) {
              if (widget.questionModel.option4.toString() ==
                  widget.questionModel.correctOption.toString()) {
                print("${widget.questionModel.correctOption}");
                setState(() {
                  optionSelected = widget.questionModel.option4.toString();
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option4.toString();
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
              option: "D",
              description: widget.questionModel.option4.toString(),
              correctAnswer: widget.questionModel.correctOption.toString(),
              optionSelected: optionSelected),
        ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
