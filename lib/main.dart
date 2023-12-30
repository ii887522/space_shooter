import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:space_shooter/space_shooter_game.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: SpaceShooterGame.new));
}
