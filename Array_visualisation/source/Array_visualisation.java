import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Array_visualisation extends PApplet {

final float heightMultiplier = 1f;
final int delayTime = 0;
final int arrayLength = 1200;

int[] orderedArr = generateOrderedArray(arrayLength);
int[] randomArr = generateRandomArray(arrayLength);
int[] unorderedArr = orderedArr;

public void setup() {
  
  unorderedArr = randomiseArray(unorderedArr);
}


public void draw() {                                                        //This one is actually pretty cool, and it works quite well
  background(0);
  if(mousePressed && mouseButton == LEFT){
     unorderedArr =  generateOrderedArray(arrayLength);
     unorderedArr = randomiseArray(unorderedArr);
  }
  
  int[] arr = unorderedArr;
  boolean sorted = false;
  if (!sorted) {
    sorted = true;
    visualiseArray(arr, false);
    delay(delayTime);
    for (int i = 0; i < arr.length-1; i++) {
      arr = bubbleSortStep(arr, i);
    }
  } else{
    visualiseArray(arr, true);
      
  }
}

public int[] generateRandomArray(int n) {
  int[] arr = new int[n];
  for (int i = 0; i < n; i++) {
    int randint = (int) random(1023)+1;
    arr[i] = randint;
  }
  return arr;
}

public int[] generateOrderedArray(int n) {
  int[] arr = new int[n];
  for (int i = 0; i < n; i++) {
    arr[n-i-1] = i+1;
  }
  return arr;
}


public void visualiseArray(int[] arr, boolean sorted) {
  
  strokeWeight(0);
  int n = arr.length;
  int max = max(arr);
  float barWidth = width/n;
  for (int i = 0; i < n; i++) {
    float barHeight = height*heightMultiplier*arr[i]/max;
    fill(255*arr[i]/max, 0, 255*max/arr[i], 205);
    rect(i*barWidth, height-barHeight, barWidth, barHeight);
  }
}

public int[] bubbleSort(int[] arr) {
  boolean sorted = false;
  while (!sorted) {
    sorted = true;
    for (int i = 0; i < arr.length-1; i++) {
      arr = bubbleSortStep(arr, i);
    }
  }
  return arr;
}

public int[] bubbleSortStep(int[] arr, int i) {
  if (arr[i] > arr[i+1]) {
    int temp = arr[i];
    arr[i] = arr[i+1];
    arr[i+1] = temp;
  }
  return arr;
}

public int[] randomiseArray(int[] arr){
   for(int i = 0; i < arr.length*256; i++){
       int r0 = (int) random(0, arr.length-1);
       int r1 = (int) random(0, arr.length-1);
       int temp = arr[r0];
       arr[r0] = arr[r1];
       arr[r1] = temp;
     
   }
   return arr; 
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Array_visualisation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
