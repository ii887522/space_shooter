import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter/components/bullet.dart';
import 'package:space_shooter/components/explosion.dart';
import 'package:space_shooter/space_shooter_game.dart';

const enemySize = 50.0;

class Enemy extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(size: Vector2.all(enemySize), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 250 * dt;
    if (position.y > game.size.y) removeFromParent();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}
