import 'dart:io';

class Calculator {
  // Addition
  double add(double num1, double num2) => num1 + num2;

  // Subtraction
  double subtract(double num1, double num2) => num1 - num2;

  // Multiplication
  double multiply(double num1, double num2) => num1 * num2;

  // Division with error handling
  double divide(double num1, double num2) {
    if (num2 == 0) {
      throw Exception("Division by zero is not allowed.");
    }
    return num1 / num2;
  }
}


double getNumber(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    try {
      return double.parse(input!);
    } catch (e) {
      print("Invalid input. Please enter a valid number.");
    }
  }
}

String getOperator() {
  const validOperators = ['+', '-', '*', '/', '%', '^'];
  while (true) {
    stdout.write("Enter an operator (+, -, *, /, %, ^): ");
    String? input = stdin.readLineSync();
    if (validOperators.contains(input)) {
      return input!;
    } else {
      print("Invalid operator. Please choose one of (+, -, *, /, %, ^).");
    }
  }
}

Future<void> calculate(Calculator calc) async {
  try {
    double num1 = getNumber("Enter the first number: ");
    double num2 = getNumber("Enter the second number: ");
    String operator = getOperator();

    double result;
    switch (operator) {
      case '+':
        result = calc.add(num1, num2);
        break;
      case '-':
        result = calc.subtract(num1, num2);
        break;
      case '*':
        result = calc.multiply(num1, num2);
        break;
      case '/':
        result = calc.divide(num1, num2);
        break;
      case '%':
        result = num1 % num2;
        break;
      case '^':
        result = num1;
        for (int i = 1; i < num2; i++) {
          result *= num1;
        }
        break;
      default:
        throw Exception("Unsupported operator.");
    }

    // Delay the result display by 5 seconds
    print("Calculating...");
    await Future.delayed(Duration(seconds: 5));
    print("Result: $result");
  } catch (e) {
    print("Error: ${e.toString()}");
  }
}

void main() {
  Calculator calc = Calculator();
  while (true) {
    calculate(calc);

    stdout.write("Do you want to perform another calculation? (y/n): ");
    String? choice = stdin.readLineSync();
    if (choice?.toLowerCase() != 'y') {
      print("Goodbye!");
      break;
    }
  }
}
