import 'package:flutter/material.dart';
import 'package:gateprep/views/App%20view/home.dart';
import 'package:gateprep/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  const Results(
      {super.key,
      required this.correct,
      required this.incorrect,
      required this.total});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        
          height: MediaQuery.of(context).size.height,
          child: Center(
            
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "You answerd ${widget.correct} answers correctly"
                " and ${widget.incorrect} answers incorrect out of ${widget.total}",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: amberButton(context: context,lable: "Go to Home"))
            ]),
          )),
    );
  }
}
