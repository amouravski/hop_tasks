#!/usr/bin/env dart

library hop_runner;

import 'dart:io';

import 'package:args/args.dart';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import 'package:pathos/path.dart' as pathos;

void main() {
  addTask('package-layout', createPubPackageLayout());
  runHop();
}

final List<String> LAYOUT = [
    'pubspec.yaml',
    'README.md',
    'LICENSE.md',
    'bin/',
    'doc/',
    'example/',
    'lib/',
    'lib/src/',
    'test/',
    'tool/',
    'web/'
];

Task createPubPackageLayout() {
  return new Task.sync((TaskContext ctx) {
    ctx.info(ctx.arguments.rest.toString());
    ctx.info('Creating Pub package layout for ${pathos.current}.');
    for (String path in LAYOUT) {
      var f = new File(pathos.absolute(path));
      var d = new Directory(pathos.absolute(path));
      ctx.info('Creating $path');
      if (!f.existsSync() && !d.existsSync()) {
        if (path.endsWith('/')) {
          d.createSync();
        } else {
          f.createSync();
        }
      }
    }
    return true;
  });
}
