import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  List<String> welcomeImages = [
    "assets/welcome1.jpg",
    "assets/welcome1.jpg",
    "assets/welcome1.jpg",
  ];
  List<Color> colourCard = [Colors.white, Colors.white, Colors.white];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: welcomeImages.length,
            stackNum: 3,
            swipeEdge: 5.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.height * 0.8,
            cardBuilder: (context, index) => Card(
              shadowColor: Colors.red,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.deepPurple,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                child: Column(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping

              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              if (index >= welcomeImages.length - 1) {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
