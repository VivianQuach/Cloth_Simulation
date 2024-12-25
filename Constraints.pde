class Constraints{
  ArrayList<Particle> particle; 
  int row, column; 
  float spacing; 
  //PLAY HERE
  PVector gravity = new PVector(0, 1000); 
  
  Constraints(ArrayList<Particle> particle, int row, int column, float spacing){
    this.particle = particle; 
    this.row = row; 
    this.column = column;
    this.spacing = spacing;
  }
  
  void update(float dt){
    applyGravity();
    apply_spring_force(); 
    applyConstraints();
    resolveCollision();
    update_position(dt);
  }
  
  void applyGravity(){
    for(Particle p :particle){
      if(!p.isFixed){
        p.acceleration.add(PVector.div(gravity, p.inverse_mass));
      }
    }
  }

  void apply_spring_force() {
        for (int y = 0; y < row; y++) {
            for (int x = 0; x < column; x++) {
                int i = x + y * column;

                //Apply spring force between the current particle and its neighbors
                if (x < column - 1) {
                    //ight neighbor
                    int right = i + 1;
                    apply_spring_force_between(particle.get(i), particle.get(right), spacing);
                }
                if (y < row - 1) {
                    //Below neighbour
                    int below = i + column;
                    apply_spring_force_between(particle.get(i), particle.get(below), spacing);
                }
                if (x < column - 1 && y < row - 1) {
                    //Bottom-right neighbour
                    int bottomRight = i + column + 1;
                    apply_spring_force_between(particle.get(i), particle.get(bottomRight), (float) Math.sqrt(2) * spacing);
                }
                if (x > 0 && y < row - 1) {
                    //Bottom-left neighbour
                    int bottomLeft = i + column - 1;
                    apply_spring_force_between(particle.get(i), particle.get(bottomLeft), (float) Math.sqrt(2) * spacing);
                }
            }
        }
    }
    
    void apply_spring_force_between(Particle p1, Particle p2, float restLength) {
        PVector delta = PVector.sub(p2.current_position, p1.current_position);
        float distance = delta.mag();
        float maxStretchFactor = 1.2; //20% stretch
        float maxLength = restLength * maxStretchFactor;
        
        //Hooke's Law for elastic behavior
        //PLAY HERE (Stiffness and damping) 
        //Higher stiffness = less stiff 
        //Higher damping = result in less bouncy (more blocky movements)
        float stiffness = 30; //Stiffness constant 
        float damping = 1; //For smoother oscillations
        PVector relativeVelocity = PVector.sub(p2.current_position, p1.current_position);
        PVector springForce = delta.copy().normalize().mult(-stiffness * (distance - restLength));
        springForce.add(relativeVelocity.mult(-damping)); //Add damping
                
        //Spring force to accelerations
        if (!p1.isFixed) {
            p1.acceleration.add(PVector.div(springForce, p1.inverse_mass));
        }
        if (!p2.isFixed) {
            p2.acceleration.sub(PVector.div(springForce, p2.inverse_mass));
        }

        //Max stretch constraint
        if (distance > maxLength) {
            float correctionFactor = (distance - maxLength) / distance;
            PVector correction = delta.copy().mult(0.5f * correctionFactor);
    
            //Apply corrections to maintain spacing
            if (!p1.isFixed) {
                p1.current_position.add(correction);
            }
            if (!p2.isFixed) {
                p2.current_position.sub(correction);
            }
        }
    }

  void update_position(float dt){
    for(Particle p1: particle){
      if(!p1.isFixed)
        p1.update_pos(dt); 
    }
  }
  
  void resolveCollision(){
    for(int y = 0; y < row;  y++){
      for(int x = 0; x < column; x++){
        int i = x + y * column; 
        if(i + column < particle.size() && y != row - 1){
          if(particle.get(i).current_position.y == particle.get(i + column).current_position.y && !particle.get(i).isFixed){
             particle.get(i + column).previous_position = new PVector(particle.get(i + column).current_position.x, particle.get(i + column).current_position.y); 
             particle.get(i + column).current_position = new PVector(particle.get(i + column).current_position.x, particle.get(i + column).current_position.y - spacing); 
          }
        }
      }
    }
  }
  
  void applyConstraints(){
    PVector topLeft = new PVector(0, 0);  //Top-left corner of the rectangle
    PVector bottomRight = new PVector(800, 600);  //Bottom-right corner of the rectangle
    for (int y = 0; y < row; y++) {
      for (int x = 0; x < column; x++) {
            int i = x + y * column;
            //Boundary Constraints
            Particle p = particle.get(i);
            if (!p.isFixed) {
                if (p.current_position.x < topLeft.x + p.radius) {
                    p.current_position.x = topLeft.x + p.radius;
                } else if (p.current_position.x > bottomRight.x - p.radius) {
                    p.current_position.x = bottomRight.x - p.radius;
                }
                if (p.current_position.y > bottomRight.y - p.radius) {
                    p.current_position.y = bottomRight.y - p.radius;
                }
            }
        }
     }
  }
}
