import peasy.*;

int DIM = 128;
PeasyCam cam;
ArrayList<PVector> MandelBulb = new ArrayList<PVector>();

void setup(){
  size(800, 800, P3D);
  cam = new PeasyCam(this, 500);
   for(int i = 0; i<DIM; i++){
      for(int j = 0; j<DIM; j++){
        boolean edge = false;
        for(int k =0; k<DIM; k++){
          float x = map(i,0,DIM,-1,1);
          float y = map(j,0,DIM,-1,1);
          float z = map(k,0,DIM,-1,1);

    
           PVector zeta = new PVector(0,0,0);
           int n = 3;
           int maxiterations= 20;
           int iteration = 0;
           while(true){
           Spherical sphericalz = spherical(zeta.x,zeta.y,zeta.z);
           float newx = pow(sphericalz.r,n)*sin(sphericalz.theta*n)*cos(sphericalz.phi*n);
           float newy = pow(sphericalz.r,n)*sin(sphericalz.theta*n)*sin(sphericalz.phi*n);
           float newz = pow(sphericalz.r,n)*cos(sphericalz.theta*n);
           zeta.x = newx +x;
           zeta.y = newy +y;
           zeta.z = newz +z;
           iteration++;
           if( sphericalz.r > 2){
             if(edge){edge = false;}
             break;
           }
           if (iteration > maxiterations){
             if(!edge){
                 edge = true;
                 MandelBulb.add(new PVector(x*100,y*100,z*100));
             }
           break;
           }
           }
           
       
        }
      }
    }
}


class Spherical{
 float r,theta,phi;
 Spherical(float r, float theta, float phi){
      this.r = r;
      this.theta = theta;
      this.phi =phi;
 }
}

Spherical spherical(float x, float y, float z){
           float r = sqrt(x*x+y*y +z*z);
           float theta = atan2( sqrt(x*x+y*y), z);
           float phi = atan2(y,x);
           return new Spherical(r,theta,phi);
}

void draw(){
background(0);

for(PVector v : MandelBulb){
 stroke(255);
 point(v.x, v.y, v.z);
 
  
}
   
}
