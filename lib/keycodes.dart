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

import 'package:flutter/services.dart';

const _deleteKeyId = 0x10000007F;
const _backspaceKeyId = 0x100000008;
const _cKeyId = 0x00000063;
const _vKeyId = 0x00000076;

extension KeyCodes on RawKeyEvent {
  bool isClear() =>
      logicalKey.keyId == _deleteKeyId || logicalKey.keyId == _backspaceKeyId;

  bool isDigit() {
    final codeUnit = character?.codeUnitAt(0) ?? 0;
    return codeUnit >= 0x30 && codeUnit <= 0x39;
  }

  bool isCopy() =>
      (isMetaPressed || isControlPressed) && logicalKey.keyId == _cKeyId;

  bool isPaste() =>
      (isMetaPressed || isControlPressed) && logicalKey.keyId == _vKeyId;
}
