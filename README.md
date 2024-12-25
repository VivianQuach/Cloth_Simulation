# Cloth Simulation 

This project implements a basic physics-based cloth simulation using Processing. 
The simulation models particles and constraints to simulate the behaviour of a piece of cloth under various forces and constraints.

### What is a cloth? 
Based off of Google, it is a "fabric or material formed by weaving, knitting, pressing, or felting natural or synthetic fibers."
Personally, I think of it as the material that always forces me to clean—truly sad! Oh wait, that’s a rag, a subset of cloth.  <br> 
But there’s something fascinating about cloth and the way it moves when we lay it down or hang it on a line. I
nspired by that, I created a simulation of a cloth hanging at two points. 
In this simulation, you can move vertices (particles) around and watch the cloth respond realistically to those changes.

### How the Simulation Works? 
The simulation represents the cloth as a grid of particles connected by edges. 
Each particle has properties like position, velocity, and mass, and the edges act as springs that simulate the stretchiness of the fabric. 
The system applies forces and constraints to simulate realistic cloth behavior.<br>
#### Here's a more detailed breakdown of the simulation components:
1. Particle System: Each vertex in the grid is represented as a particle, which has properties like position, velocity, and mass. These particles can either be fixed or dynamic.
2. Constraints: The edges between particles behave like springs, maintaining their length to simulate the cloth's structure. These constraints are resolved iteratively to keep the grid stable and realistic.
3. Forces: Forces like gravity are applied to each particle to make the cloth react to external influences.
5. Verlet Integration: This physics approach updates particle positions based on their current and previous positions, providing stability and realism
6. Hook's Law: This principle models the spring-like behavior of the edges between particles, ensuring the cloth doesn't stretch beyond a certain point.

### How to run
1. Get processing 
2. Clone my repository 
3. Open Main.pde and run it 

Once you’re running the simulation, feel free to experiment with sections marked with "// PLAY HERE." By modifying these values, you can see how they affect the cloth's movement.  <br>
You can also interact with the simulation by dragging particles around, observing how the rest of the cloth responds.

#### In the future, I plan to add the following features:
- Cloth collision with objects in the environment.
- Better optimization for simulating larger pieces of cloth.


