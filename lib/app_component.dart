import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';

@Component(selector: 'my-app', templateUrl: './app_component.html', styleUrls: [
  './app_component.css'
], directives: [
  NgFor,
  NgIf,
  NgStyle,
  formDirectives,
  materialInputDirectives,
  MaterialIconComponent,
  MaterialButtonComponent,
  materialNumberInputDirectives
])
class AppComponent implements OnInit {
  var name = 'Gradient Table';
  var tableSize;
  var size = 32;
  var rows = [];
  var columns = [];
  double maxRange = 256;
  Control form;
  get checkValid => demoValidator;

  AppComponent() {
    form = Control();
  }

  @override
  void ngOnInit() {}

  createTable() {
    rows = List.generate(tableSize + 1, (i) => i);
    columns = List.generate(tableSize + 1, (i) => toColumnName(i));
    size = tableSize;
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

  checkIfInputValid() {
    if ((tableSize != null && (tableSize < 2 || tableSize > 100) || tableSize == null)) {
      return true;
    }
    return false;
  }
}
