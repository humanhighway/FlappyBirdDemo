part of GameLib;

class Pipe extends Sprite {
  
  static const int UP = 0;
  static const int DOWN = 1;
  
  Pipe_top top;
  Pipe_section section;
  num _topHeight;
  int _type;
  int _h;
  
  Pipe(int type, int h) {
    _type = type;
    _h = h;
    int ty = 0;
    
    top = new Pipe_top();
    _topHeight = top.height;
    
    switch (type) {
      case UP:
        ty = 58;
        break;
      case DOWN:
        top..y = _h
           ..scaleY = -1;
        break;
    }
    
    section = new Pipe_section()
              ..y = ty
              ..height = _h - _topHeight;
    
    addChild(section);   
    addChild(top);
  }
  
  void rebuild(int h) {
    _h = h;
    num ty = 0;
    switch (_type) {
      case UP:
        ty = _topHeight;
        top..y = 0
           ..scaleY = 1;
        break;
      case DOWN:
        top..y = _h
           ..scaleY = -1;
        break;
    }
    section..y = ty
            ..height = _h - _topHeight;
  }
}