import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:three_pam/finalPage.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => SecondRouteState();
}

class Intrebare {
  String ask;
  List<Raspuns> answers;
  String correct;

  Intrebare({required this.ask, required this.answers, required this.correct});
}

class Raspuns {
  String rasp;
  bool valoare;

  Raspuns({required this.rasp, required this.valoare});
}

class Rezultate {
  int rating;
  int scor;
  int corect;
  int timp;

  Rezultate(
      {required this.rating,
      required this.scor,
      required this.corect,
      required this.timp});
}

class SecondRouteState extends State<SecondRoute> {
  double percent = 0.0;
  late Timer timer;
  int index = 0;
  final Rezultate rezultate = Rezultate(rating: 0, scor: 0, corect: 0, timp: 0);

  List<Intrebare> intrebari = [
    Intrebare(
        ask:
            'Care matimatician a descifrat codul nazist Enigma?',
        answers: [
          Raspuns(rasp: 'Paul Guldin', valoare: false),
          Raspuns(rasp: 'Elon Musk', valoare: false),
          Raspuns(rasp: 'Alan Turing', valoare: false),
          Raspuns(rasp: 'Bernhard Riemann', valoare: false),
        ],
        correct: 'Alan Turing'),
    Intrebare(
        ask:
            'Unde a fost găsit în 1905, cel mai mare diamant brut din lume, Cullinan?',
        answers: [
          Raspuns(rasp: 'China', valoare: false),
          Raspuns(rasp: 'Africa de Sud', valoare: false),
          Raspuns(rasp: 'Peru', valoare: false),
          Raspuns(rasp: 'Nigeria', valoare: false),
        ],
        correct: 'Africa de Sud'),
    Intrebare(
        ask:
            'Cine a fost compozitorul operei Rigoletto?',
        answers: [
          Raspuns(rasp: 'Antonio Pavarotti', valoare: false),
          Raspuns(rasp: 'Eugen Doga', valoare: false),
          Raspuns(rasp: 'Giuseppe Verdi', valoare: false),
          Raspuns(rasp: 'Antonio Vivaldi', valoare: false),
        ],
        correct: 'Giuseppe Verdi'),
    Intrebare(
        ask:
            'Care este cea mai mică țară din lume?',
        answers: [
          Raspuns(rasp: 'Republica Moldova', valoare: false),
          Raspuns(rasp: 'Vatican', valoare: false),
          Raspuns(rasp: 'Nigeria', valoare: false),
          Raspuns(rasp: 'Luxemburg', valoare: false),
        ],
        correct: 'Vatican'),
    Intrebare(
        ask:
            'Din ce gen muzical a rezultat muzica rock?',
        answers: [
          Raspuns(rasp: 'Phonk', valoare: false),
          Raspuns(rasp: 'Blues', valoare: false),
          Raspuns(rasp: 'Ragga', valoare: false),
          Raspuns(rasp: 'Grime', valoare: false),
        ],
        correct: 'Blues')
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        percent += 1;
        if (percent >= 100) {
          getResults();
          timer.cancel();
          percent = 0.0;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FinalRoute(
                      data: rezultate,
                    )),
          );
        }
      });
    });
  }

  getResults() {
    setState(() {
      rezultate.timp = percent.toInt();
    });
    for (var item in intrebari) {
      for (var el in item.answers) {
        if (el.valoare == true) {
          if (el.rasp == item.correct) {
            setState(() {
              rezultate.corect += 1;
              rezultate.rating = rezultate.rating + 3;
              rezultate.scor = rezultate.scor + 3;
            });
          } else {
            setState(() {
              rezultate.rating -= 2;
              rezultate.scor -= 1;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.timelapse,
                      color: Colors.grey,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Text(
                      ' ${100 - percent.toInt()}sec',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(123, 123, 123, 1),
                      ),
                    ),
                  ]),
            ),
            Container(
              width: 350,
              margin: const EdgeInsets.only(bottom: 44.0),
              child: LinearPercentIndicator(
                width: 342,
                lineHeight: 10.0,
                percent: percent / 100,
                animateFromLastPercent: true,
                barRadius: const Radius.circular(10),
                backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
                progressColor: const Color.fromRGBO(11, 188, 0, 1),
                animation: true,
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(bottom: 24.0),
              child: Text.rich(
                TextSpan(
                    text: 'Intrebarea ${index + 1} of 5\n',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(123, 123, 123, 1),
                        height: 1.7),
                    children: <TextSpan>[
                      TextSpan(
                        text: intrebari[index].ask,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(37, 44, 50, 1),
                        ),
                      ),
                    ]),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 32.0),
              child: Column(
                  children: intrebari[index].answers.map((Raspuns item) {
                return Container(
                  height: 54,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CheckboxListTile(
                    shape: const CircleBorder(),
                    title: Text(item.rasp.toString()),
                    value: item.valoare,
                    onChanged: (bool? value) {
                      setState(() {
                        item.valoare = !item.valoare;
                      });
                    },
                  ),
                );
              }).toList()),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  if (index + 1 < intrebari.length) {
                    setState(() {
                      index += 1;
                    });
                  } else {
                    getResults();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinalRoute(data: rezultate)),
                    );
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(37, 44, 50, 1)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(130, 12, 130, 12)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14))),
                child: const Text('Următoarea'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
