import 'package:code_test/code_test.dart' as code_test;

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
}
