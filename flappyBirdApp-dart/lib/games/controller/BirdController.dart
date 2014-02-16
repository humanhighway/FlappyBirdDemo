
part of GameLib;

class BirdController {

  Bird _bird;
  
  num _currentRotation = 0;
  num _force = 0;
  num _oriX;
  num _oriY;
  int _limitY;
  static num _radians = PI / 180;

  EventStreamSubscription _eventStreamSubscription;
  
  BirdController(Bird bird) {
      _bird = bird;      
      _oriX = bird.x;
      _oriY = bird.y;
      // limit height = total height - ground height - bird fall height;
      _limitY = new GameModel().gameHeight - 50 - 30;
  }
  
  void fly() {
    
    if (_eventStreamSubscription == null) {
      _eventStreamSubscription = _bird.onEnterFrame.listen(_fly);
    }
    
    if (_force < 0) {
      _force = 15;
    } else {
      _force += 11;
    }
    resources.getSound("Tap").play();
  }
  
  void _fly(e) {
    
    if (_force < -5) {
      _force = -5;
    }
    
    if (_currentRotation > 90) {
      _currentRotation = 90;
    } else if (_currentRotation < -40) {
      _currentRotation = -40;
    } else {
      _currentRotation -= _force * .7;
    }
    _bird.rotation = _currentRotation * _radians;
    _force -= 1.1;
    
    num ty = _bird.y - _force;
    if (ty > _limitY) {
      ty = _limitY;
      landing();
    } else if (ty < 0) {
      ty = 0;
    }
    _bird.y = ty;
  }
  
  void landing() {
    GameModel model = new GameModel();
    if (model.status != GameModel.WAIT_TO_BACK_BEGIN) {
      model.status = GameModel.GAME_OVER;
    }
    model.isBirdLanding = true;
    _eventStreamSubscription.cancel();
    _eventStreamSubscription = null;
    _bird.stop();
  }
  
  void stop() {
    _eventStreamSubscription.cancel();
    _eventStreamSubscription = null;
  }
  
  void reset() {
    _bird..x = _oriX 
         ..y = _oriY
         ..rotation = 0;
    _currentRotation = 0;
    _force = 0;
    _bird.play();
  }
  
}