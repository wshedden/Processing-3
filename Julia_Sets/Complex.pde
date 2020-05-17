class Complex {
  float real;
  float imaginary;

  public Complex(float r, float i) {
    real = r;
    imaginary = i;
  }

  public Complex add(Complex c) {
    return new Complex(real+c.real, imaginary+c.imaginary);
  }

  public Complex squared() {
    return new Complex(sq(real)-sq(imaginary), 2*real*imaginary);
  }
  
  public String toString(){
     return String.format("%.1f + %.1fi", real, imaginary);  
  }
  
}
