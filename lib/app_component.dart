import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/focus/focus.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';
import 'package:angular_components/material_button/material_button.dart';

@Component(selector: 'my-app', templateUrl: './app_component.html', styleUrls: [
  './app_component.css'
], directives: [
  NgFor,
  NgIf,
  NgStyle,
  formDirectives,
  AutoFocusDirective,
  materialNumberInputDirectives,
  MaterialButtonComponent
])
class AppComponent {
  String name = 'Gradient Table';
  num tableSize;
  num size = 32;
  List<int> rows = [];
  List<String> columns = [];
  num maxRange = 256;
  get checkValid => demoValidator;

  AppComponent() {}

  createTable() {
    final int tSize = tableSize;
    rows = List.generate(tSize + 1, (i) => i);
    columns = List.generate(tSize + 1, (i) => toColumnName(i));
    size = tSize;
  }

  String toColumnName(columNum) {
    var ret = '';
    if (columNum == 0) {
      return 'null';
    } else {
      for (var a = 1, b = 26; (columNum -= a) >= 0; a = b, b *= 26) {
        ret = String.fromCharCode(((columNum % b) / a).toInt() + 65) + ret;
      }
      return ret;
    }
  }

  String getColor(i, j) {
    num color;
    num gapvh = 256 / (size);
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

  String demoValidator(String text) {
    final num size = tableSize;
    if (size == null) return null;

    if (size < 2 || size > 100) return 'Size must be 2 <= N <= 100.';

    if (size is! int) return 'Please enter valid integer.';
  }

  bool checkIfInputValid() {
    final size = tableSize;
    if ((size != null && ((tableSize is! int) || size < 2 || size > 100)) || size == null) {
      return true;
    }
    return false;
  }
}
