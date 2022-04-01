/*
Copyright (c) 2022 Razeware LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculator.dart';
import 'keycodes.dart';
import 'tile.dart';

class CalculatorBody extends StatelessWidget {
  final _calculator = Calculator();

  CalculatorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Focus(
        autofocus: true,
        onKey: _onKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ValueListenableBuilder<String>(
                valueListenable: _calculator.displayNotifier,
                builder: (_, String value, __) => Text(
                  value,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF158443),
                  ),
                ),
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: [
                Tile('7', _calculator.appendDigit),
                Tile('8', _calculator.appendDigit),
                Tile('9', _calculator.appendDigit),
                Tile('4', _calculator.appendDigit),
                Tile('5', _calculator.appendDigit),
                Tile('6', _calculator.appendDigit),
                Tile('1', _calculator.appendDigit),
                Tile('2', _calculator.appendDigit),
                Tile('3', _calculator.appendDigit),
                Tile('0', _calculator.appendDigit),
                Tile('+', (_) => _calculator.appendOperator(Operator.plus)),
                Tile('-', (_) => _calculator.appendOperator(Operator.minus)),
                Tile('AC', (_) => _calculator.clear()),
              ],
            ),
          ],
        ),
      );

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    if (event.isDigit()) {
      _calculator.appendDigit(event.character!);
      return KeyEventResult.handled;
    } else if (event.isClear()) {
      _calculator.clear();
      return KeyEventResult.handled;
    } else if (event.character == '+') {
      _calculator.appendOperator(Operator.plus);
      return KeyEventResult.handled;
    } else if (event.character == '-') {
      _calculator.appendOperator(Operator.minus);
      return KeyEventResult.handled;
    } else if (event.isCopy()) {
      Clipboard.setData(ClipboardData(text: _calculator.displayNotifier.value));
      return KeyEventResult.handled;
    } else if (event.isPaste()) {
      Clipboard.getData(Clipboard.kTextPlain)
          .then((data) => _calculator.replaceDigits(data?.text));
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
