import 'dart:io';

import 'package:code_test/code_test.dart' as code_test;

/**
 * 2021.03.07
 * Reference https://dart.dev/samples
 */
void main(List<String> arguments) {
  print('Hello world: ${code_test.calculate()}!');

  // Reference https://dart.dev/samples

  // Variables
  var name = 'cremazer';
  print(name);

  var year = 2021;
  print(name + ' Hello ${year}');
  print(name + ' ${name} ${year}');

  var pi = 3.14;
  // print('pi = ' + pi); // not use
  print('pi = ${pi}');

  var arrData = ['Jan', 'Feb', 'Mar'];
  print(arrData);

  bool isCheck = false;
  print(isCheck);

  var isBoolean = true;
  print(isBoolean);

  // Control flow statements
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20st century');
  } else {
    print('past century');
  }

  for (var item in arrData) {
    print(item);
  }

  var count = 12;
  var months = '';
  for (int month = 1; month <= count; month++) {
    // print(month);
    if (month > 1) months += ',';
    // months += month;  // not use
    // months += '' + month;  // not use
    months += month.toString();
    // How to cast an Integer?
  }
  print(months);

  // Functions
  var result = fibonacci(7);
  print('fibonacci result = ${result}');

  var flybyObjects = ['leftturn', 'flying', 'take-off', 'rightturn', 'landing'];
  flybyObjects.where((name) => name.contains('turn')).forEach(print);

  // Classes
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  var voyager2 = Spacecraft.unlaunched('cremazer');
  print(voyager.name);
  print(voyager.launchDate);

  print(voyager2.name);
  print(voyager2.launchDate);
  voyager2.describe();
  voyager2.launchDate = DateTime(1977, 9, 5);
  print('voyager2 launchYear = ${voyager2.launchYear}');
  // call method
  voyager2.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();

  // 상속 Inheritance
  var orbiter1 = Orbiter('KITSAT-I', DateTime(1992, 8, 11), 2000);
  print(orbiter1.name);
  print(orbiter1.launchDate);
  orbiter1.describe();

  // mixin
  var pilotedCraft = PilotedCraft('KITSAT-II', DateTime(1993, 9, 26));
  print(pilotedCraft.name);
  print(pilotedCraft.launchDate);
  pilotedCraft.describe();
  pilotedCraft.describeCrew();

  // Async
  // 1초 뒤 출력하기
  printWithDelay('ok google');

  Iterable<String> objects = ['First', 'Second', 'Third'];
  report(pilotedCraft, objects);

  // Exceptions
  testException(objects);
}

/*
  피보나치 수열
  n 번째 숫자 구하기
*/
int fibonacci(int n) {
  // print(' -> ${n}');
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

/**
 * 우주선
 */
class Spacecraft {
  String name;
  DateTime launchDate;

  // 기본생성자
  Spacecraft.unlaunched(String name) : this(name, null);

  Spacecraft(this.name, this.launchDate);

  // read-only non-final property
  int get launchYear => launchDate?.year;

  // Method.
  void describe() {
    print('Spacecraft: $name');
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

/**
 * 인공위성
 */
class Orbiter extends Spacecraft {
  // 고도
  double altitude;
  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate);

  // Method.
  void describe() {
    print('Orbiter: $name');
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
      print('Altitude: $altitude km');
    } else {
      print('Unlaunched');
    }
  }
}

/**
 * 파일럿
 */
mixin Piloted {
  // 우주 비행사
  int astronauts = 1;
  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(String name, DateTime launchDate) : super(name, launchDate);
}

const oneSecond = Duration(seconds: 1);
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (var object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object'; // ?
    /*
    What does 'yield' keyword do in flutter?
    https://stackoverflow.com/questions/55776041/what-does-yield-keyword-do-in-flutter
    */
  }
}

Future<void> testException(var flybyObjects) async {
  try {
    for (var object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObjects.clear();
  }
}
