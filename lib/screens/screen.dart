import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xogame/const.dart';
import 'package:xogame/screens/ui/color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scorebord = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Its` ${lastValue} Turn".toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 58),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: boardWidth,
            width: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: EdgeInsets.all(16),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(Game.boardlenth, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;

                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scorebord, 3);
                              if (gameOver) {
                                result = "$lastValue is the winner";
                              } else if (!gameOver && turn == 9) {
                                result = "it`s a Draw";
                                gameOver = true;
                              }

                              if (lastValue == "X")
                                lastValue = "O";
                              else
                                lastValue = "X";
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink.shade600,
                            fontSize: 64.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 54),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
            child: Text(
              "Play Again",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scorebord = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            color: MainColor.secondaryColor,
          ),
          // Container(
          //     child: isloaded
          //         ? Text("erroe")
          //         : Container(
          //             height: 50,
          //             child: AdWidget(ad: bannerad!),
          //           )),
          // SizedBox(
          //   height: 10,
          // ),
          // Text("sdcvbn")
        ],
      ),
    );
  }
}
