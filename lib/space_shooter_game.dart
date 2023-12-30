import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';
import 'package:space_shooter/components/enemy.dart';
import 'package:space_shooter/components/player.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    player = Player();

    addAll([
      await loadParallaxComponent(
        [
          ParallaxImageData('stars_0.png'),
          ParallaxImageData('stars_1.png'),
          ParallaxImageData('stars_2.png'),
        ],
        baseVelocity: Vector2(0, -5),
        repeat: ImageRepeat.repeat,
        velocityMultiplierDelta: Vector2(0, 5),
      ),
      player,
      SpawnComponent(
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -enemySize),
        factory: (index) => Enemy(),
      ),
    ]);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}
