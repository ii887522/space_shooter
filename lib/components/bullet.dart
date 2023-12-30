import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter/space_shooter_game.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Bullet({
    super.position,
  }) : super(size: Vector2(25, 50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(8, 16),
      ),
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += -500 * dt;
    if (position.y < -height) removeFromParent();
  }
}
