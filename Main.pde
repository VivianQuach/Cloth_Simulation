int row, column;
float spacing; 
float offsetX, offsetY; //Location of cloth
float radius; 
ArrayList<Particle> particle; 
Constraints constraints; 
Particle selectedParticle = null; //Particle being dragged
float mouseThreshold = 10; //Distance to detect a particle near the mouse


void setup() {
  size(800, 600);
  background(255); 
  frameRate(60); 
  smooth(); 
  row = 10; 
  column = 10; 
  spacing = 20; 
  offsetX = (width - (column - 1) * spacing) / 2;
  offsetY = (height - (row - 1) * spacing) / 2;
  radius = 5; 
  particle = new ArrayList<Particle>(); 
  int fixed = 9; 
  
  for (int y = 0; y < row; y++){
    for (int x = 0; x < column; x++){
      if(x == 0 && y == 0 || x == fixed && y == 0){
        particle.add(new Particle(x*spacing + offsetX, y*spacing + offsetY, radius));
      }else{
        particle.add(new Particle(x*spacing + offsetX, y*spacing + offsetY-5, radius));
      }
    }
  }
  
  //Make fixed points
  particle.get(0).setFixedPosition(); 
  particle.get(column - 1).setFixedPosition();
  
  constraints = new Constraints(particle, row, column, spacing); 
}

void draw(){
    background(255); 
    constraints.update(1/frameRate);
    for(int y = 0; y < row; y++){
      for(int x = 0; x < column ; x++){
        int i = x + y * column;
        //Vertices
         fill(0);
         ellipse(particle.get(i).current_position.x, particle.get(i).current_position.y, radius, radius);
        //Horizonal line 
        if (x != column - 1){
           line(particle.get(i).current_position.x,particle.get(i).current_position.y, particle.get(i + 1).current_position.x, particle.get(i + 1).current_position.y); 
        }
        //Downward line
        if(x + y + column < particle.size() && y != row - 1)
          line(particle.get(i).current_position.x,particle.get(i).current_position.y, particle.get(i + column).current_position.x, particle.get(i + column).current_position.y); 
      }
    }
  }
  
void mousePressed() {
    for (Particle p : particle) {
        if (p.isNear(mouseX, mouseY, mouseThreshold) && !p.isFixed) {
            selectedParticle = p;
            break;
        }
    }
}

void mouseDragged() {
    if (selectedParticle != null) {
        selectedParticle.current_position.set(mouseX, mouseY); 
    }
}

void mouseReleased() {
    selectedParticle = null;
}

  
