//Original code credit: Daniel Shiffman
//http://processing.org/examples/flocking.html

//Modified 9/24/14 by Gillian Smith:
//    - additional comments
//    - separation of tweakable constants

boolean MOUSE_ATTRACT = true;  // determines whether boids should be attracted by the mouse
float MOUSE_WEIGHT = 0.5;      // determines how heavily weighted the mouse steering force should be
float MOUSE_RADIUS = 30;       // controls the radius of influence around the mouse pointer 

//how much to care about each of the three behaviors
float SEP_WEIGHT = 10.0;  //separation
float ALI_WEIGHT = 1.0;  //alignment
float COH_WEIGHT = 1.0;  //cohesion

float COH_NEIGHBORDIST = 90;  //radius for boids to be cohesive with
float ALI_NEIGHBORDIST = 30;  //radius for boids to align with
float SEP_DESIREDDIST = 15;   //desired separation distance


//function called when new boids are created to determine what direction they start facing
PVector initialDirection()
{
  float angle = random(TWO_PI);
  return new PVector(cos(angle), sin(angle));
}

Flock flock;

//setup() runs once at the beginning of the program
void setup() {
  size(1000, 700);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

//draw() runs on every frame
void draw() {
  background(50);
  flock.run();
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
}

// The Boid class

class Boid {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;           // radius of the boid
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);

    // Leaving the code temporarily this way so that this example runs in JS
    velocity = initialDirection();

    location = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);    //run flocking updates
    update();        //update velocity and position
    borders();       //screen wrap-around check
    render();        //draw the boid!
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    
    // calculate mouse attraction
    PVector mf = new PVector(0, 0, 0);
    if ((this.location.x - mouseX) <= MOUSE_RADIUS && 
        (this.location.y - mouseY <= MOUSE_RADIUS)) {
      // make sure the mouse is close enough
      mf.x = mouseX - this.location.x;
      mf.y = mouseY - this.location.y;
    }
    mf.normalize();
        
    // invert mouse force if mouse is set to repel
    if (!MOUSE_ATTRACT) mf.mult(-1);

    // Arbitrarily weight these forces
    sep.mult(SEP_WEIGHT);
    ali.mult(ALI_WEIGHT);
    coh.mult(COH_WEIGHT);
    mf.mult(MOUSE_WEIGHT);
    
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(mf);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset acceleration to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    
    fill(200, 100);  //fill color for the boid (light grey, partially transparent)
    stroke(255);     //stroke color for the boid (white)
    
    //set up to draw the boid at its correct position and rotation
    pushMatrix();    
    translate(location.x, location.y);
    rotate(theta);
    
    //draw the boid as a triangle
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    
    //pop off the translation and rotation matrices ready to draw the next boid
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
  
  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = SEP_DESIREDDIST;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = ALI_NEIGHBORDIST;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      
      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = COH_NEIGHBORDIST;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } 
    else {
      return new PVector(0, 0);
    }
  }
}




// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }

}
