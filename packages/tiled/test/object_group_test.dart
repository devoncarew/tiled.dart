import 'dart:io';
import 'dart:ui';

import 'package:test/test.dart';
import 'package:tiled/tiled.dart';

void main() {
  late TiledMap map;
  setUp(() {
    return File('./test/fixtures/objectgroup.tmx').readAsString().then((xml) {
      map = TileMapParser.parseTmx(xml);
    });
  });

  group('Layer.fromXML', () {
    late ObjectGroup objectGroup;

    setUp(() {
      objectGroup = map.layerByName('Test Object Layer 1') as ObjectGroup;
    });

    test('sets name', () {
      expect(objectGroup.name, equals('Test Object Layer 1'));
    });

    test('sets class_', () {
      expect(objectGroup.class_, equals('objectLayer1Class'));
    });

    test('sets color', () {
      expect(objectGroup.colorHex, equals('#555500'));
      expect(
        objectGroup.color,
        equals(Color(int.parse('0xff555500'))),
      );
    });

    test('sets opacity', () {
      expect(objectGroup.opacity, equals(0.7));
    });

    test('sets visible', () {
      expect(objectGroup.visible, equals(true));
      objectGroup = map.layerByName('EmptyLayer') as ObjectGroup;

      expect(objectGroup.visible, equals(false));
    });

    test('populates tmxObjects', () {
      expect(objectGroup.objects.length, greaterThan(0));
    });
  });
}
