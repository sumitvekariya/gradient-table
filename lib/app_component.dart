import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/focus/focus.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_button/material_button.dart';

@Component(selector: 'my-app', templateUrl: './app_component.html', styleUrls: [
  './app_component.css'
], directives: [
  NgFor,
  NgIf,
  NgStyle,
  formDirectives,
  AutoFocusDirective,
  materialInputDirectives,
  MaterialButtonComponent
])
class AppComponent {
  var name = 'Gradient Table';
  var tableSize;
  var size = 32;
  var rows = [];
  var columns = [];
  double maxRange = 256;
  get checkValid => demoValidator;

  AppComponent() {}

  createTable() {
    final tSize = int.parse(tableSize);
    rows = List.generate(tSize + 1, (i) => i);
    columns = List.generate(tSize + 1, (i) => toColumnName(i));
    size = tSize;
  }

  String toColumnName(num) {
    var ret = '';
    if (num == 0) {
      return 'null';
    } else {
      for (var a = 1, b = 26; (num -= a) >= 0; a = b, b *= 26) {
        ret = String.fromCharCode(((num % b) / a).toInt() + 65) + ret;
      }
      return ret;
    }
  }

  String getColor(i, j) {
    var color;
    var gapvh = 256 / (size);
    if (i == 1 && j == 1) {
      color = 255;
    } else if (i == size && j == size) {
      color = 0;
    } else {
      maxRange = 256 - ((gapvh * (i + j)) / 2);
      color = maxRange;
    }
    return 'rgb(255, $color, $color)';
  }

  String demoValidator(dynamic inputText) {
    print(int.parse(inputText));
    if (inputText == null) return null;

    if (inputText == 0) return 'Input contains 0';

    if (int.parse(inputText) < 2 || int.parse(inputText) > 100)
      return 'Size must be 2 <= N <= 100.';

    // return null;
  }

  bool checkIfInputValid() {
    final size = int.parse(tableSize == null || tableSize == '' ? '0' : tableSize);
    if ((size != null && (size < 2 || size > 100) || size == null)) {
      return true;
    }
    return false;
  }
}
