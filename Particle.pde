class Particle{
  PVector current_position; 
  PVector previous_position;  
  boolean isFixed;
  PVector fixed_positions;
  float inverse_mass; 
  float radius; 
  PVector acceleration; 

  Particle(float x, float y, float radius) {
    current_position = new PVector(x,y);
    previous_position = new PVector(x,y);
    acceleration = new PVector(0,0);
    this.radius = radius;
    isFixed = false; 
    inverse_mass = 1.0f/(PI*this.radius*this.radius*10); 
    fixed_positions = new PVector(); 
  }
  void setFixedPosition(){
    isFixed = true; 
    fixed_positions = new PVector(current_position.x, current_position.y);
    
  }
  boolean isNear(float mx, float my, float threshold) {
    return PVector.dist(current_position, new PVector(mx, my)) < threshold;
  }

  
  void update_pos(float dt){
    if(!isFixed){
       //Velocity of the particle
      PVector velocity = PVector.sub(current_position, previous_position); 
      //Adds damping into the velocity (smaller the number the more damping) 
      //Play HERE
      velocity = PVector.mult(velocity, 0.98);  
      
      previous_position = new PVector(current_position.x, current_position.y);
      //Verlet Equation is used to compute its new position 
      current_position.add(velocity);
      current_position.add(PVector.mult(acceleration, dt*dt*this.inverse_mass)); 
      //Reset acceleration
      acceleration = new PVector(0f, 0f); 
    }
  }
}
