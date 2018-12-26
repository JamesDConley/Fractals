//All Code by James Conley
//With thanks to Surendra Lama for finding royalty free music and UI positioning.
//Mathematics for Fractal Generation was based on the book "Chaos and Fractals" by by Heinz-Otto Peitgen, Hartmut Jurgens and Dieter Saupe
import controlP5.*;//Control library
import java.util.ArrayList;
import ddf.minim.*;//Sound library

Minim minim;//sound library, mnim
AudioPlayer bgPlayer, buttonPlayer;//one sound effects and one background player
ControlP5 sControl;// controlP5 = sControl.
Textlabel Header;//Header label
int screen;//Screen size.
ArrayList<controlP5.Button> buttons = new ArrayList<controlP5.Button>();//buttons for splash screen in arraylist
ArrayList<controlP5.Button> screen2Buttons= new ArrayList<controlP5.Button>();//buttons for screen 2 in arraylist.
ArrayList<controlP5.Slider> sliders = new ArrayList<controlP5.Slider>();//sliders stored in the arraylist
ArrayList<Transform> added = new ArrayList<Transform>();//transformed the shape of fractal by adding.
ArrayList<controlP5.Button> fractalScreenButtons = new ArrayList<controlP5.Button>();

boolean change = false;
controlP5.Textlabel title;//title label.
FractalSuperClass superF = new FractalSuperClass();//Super class for fractal


public void setup(){//setup
    size(1500,1000);
    //fullScreen();//fullscreen 
    sControl = new ControlP5(this);//control
    minim = new Minim(this);//sound
    buttonPlayer=minim.loadFile("silence.wav"); //sound
    buttons.add(sControl.addButton("New")//button for homescreen
    .setValue(0)
    .setPosition((int)(.433*width),(int)(.2*height))
    .setSize((int)(.133*width),(int)(.03*height)));
    //button
    fractalScreenButtons.add(sControl.addButton("Back")
    .setValue(0)
    .setPosition(0,(int)(.04*height))
    .setSize((int)(.133*width),(int)(.03*height)));
    //button
    fractalScreenButtons.add(sControl.addButton("Another")
    .setValue(0)
    .setPosition(0,(int)(.08*height))
    .setSize((int)(.133*width),(int)(.03*height)));
    //button
    buttons.add(sControl.addButton("Random")
    .setValue(0)
    .setPosition((int)(.433*width),(int)(.25*height))
    .setSize((int)(.133*width),(int)(.03*height)));
    //button
    screen2Buttons.add(sControl.addButton("Add")
    .setValue(0)
    .setPosition((int)(.825*width),(int)(.3*height))
    .setSize((int)(.06*width),(int)(.03*height)));
    //button
    screen2Buttons.add(sControl.addButton("Make")
    .setValue(0)
    .setPosition((int)(.825*width),(int)(.35*height))
    .setSize((int)(.06*width),(int)(.03*height)));
    //button
     screen2Buttons.add(sControl.addButton("Clear")
    .setValue(0)
    .setPosition((int)(.825*width),(int)(.4*height))
    .setSize((int)(.06*width),(int)(.03*height)));
    //header
    title = (Header = sControl.addTextlabel("Text")
    .setText("Fractal Generator")
    .setPosition(380,35)
    .setColorValue(0x0000000)
    .setFont(createFont("NanumBrush",130)));
    //Slider
    sliders.add(sControl.addSlider("Theta_Slider")
    .setPosition((int)(.0667*width),(int)(.2*height))
    .setSize((int)(.0533*width),(int)(.5*height))
    .setRange(0.0,(float)(2*Math.PI))
    .setValue(50));
     //Slider
    sliders.add(sControl.addSlider("Psi_Slider")
    .setPosition((int)(.2*width),(int)(.2*height))
    .setSize((int)(.0533*width),(int)(.5*height))
    .setRange(0.0,(float)(2*Math.PI))
    .setValue(50));
     //Slider
    sliders.add(sControl.addSlider("R_Slider")
    .setPosition((int)(.33*width),(int)(.2*height))
    .setSize((int)(.0533*width),(int)(.5*height))
    .setRange(0,.99999)
    .setValue(50));
     //Slider
    sliders.add(sControl.addSlider("S_Slider")
    .setPosition((int)(.4667*width),(int)(.2*height))
    .setSize((int)(.0533*width),(int)(.5*height))
    .setRange(0,.99999)
    .setValue(50));
    //Slider 
    sliders.add(sControl.addSlider("E_Slider")
    .setPosition((int)(.6*width),(int)(.2*height))
    .setSize((int)(.0533*width),(int)(.5*height))
    .setRange(-2,2)
    .setValue(50));
     //Slider
    sliders.add(sControl.addSlider("F_Slider")
    .setPosition((int)(.733*width),(int)(.2*height))
    .setSize((int)(.0533*width),(int)(.5*height))
    .setRange(-2,2)
    .setValue(50));
     
     superF.init();
     screen = 1;
     //button
    for(controlP5.Button b : screen2Buttons){
        b.hide();
     }
    //slider
    for(controlP5.Slider s : sliders){
      s.hide();
    }
    //button
    for(controlP5.Button b : buttons){
      b.show();
    }
    for(controlP5.Button b : fractalScreenButtons){
      b.hide();
    }
    bgPlayer = minim.loadFile("bensound-straight.mp3");//sound got it from bensound.com
    buttonPlayer = minim.loadFile("Button Sound.wav");//sound 
    
    bgPlayer.loop();//background loop
}
//draw 
public void draw(){
    clear();   
    switch(screen){
    case 1: superF.run();
            break;
    case 2: 
            break;
    case 3: superF.run();
            break;
  }
}
public void Add(int theValue){//Method that adds the value from the sliders to draw the fractal
    float[] tempArr = new float[6];
    int i = 0;
    for(controlP5.Slider s : sliders){
    tempArr[i] = s.getValue();
    i++;
    buttonPlayer.rewind();//sound
    buttonPlayer.play();
 }
 
    added.add(new Transform(tempArr[0],tempArr[1],tempArr[2],tempArr[3],tempArr[4],tempArr[5]));//Adds all the value together

}
public void Clear(int thing){//Method that clears the value from the sliders.
    added.clear();
    buttonPlayer.rewind();
    buttonPlayer.play();
}
public void Make(int theValue){// Method that combines the value from add and draws to make fractal. 
    Fractal f = superF.getFractal();
    f.setTransforms(added);
    superF.getFG().reset();
    screen = 3;
    for(controlP5.Button b : buttons){
      b.hide();
  }
    for(controlP5.Slider s : sliders){
      s.hide();
  }
    for(controlP5.Button b : screen2Buttons){
      b.hide();
  }
    for(controlP5.Button b : fractalScreenButtons){
      b.show();
  }
    buttonPlayer.rewind();
    buttonPlayer.play();
    title.hide();
}

public void Random(int theValue){//Method that generates random fractals. 
    screen = 3;
    for(controlP5.Button b : buttons){
      b.hide();
  }
    for(controlP5.Slider s : sliders){
      s.hide();
  }
    for(controlP5.Button b : screen2Buttons){
      b.hide();
  }
    for(controlP5.Button b : fractalScreenButtons){
      b.show();
  }
    buttonPlayer.rewind();
    buttonPlayer.play();
    superF.randomize();
    title.hide();
}
public void Back(int theValue){//Method for back
    for(controlP5.Button b : buttons){
      b.show();
  }
    for(controlP5.Slider s : sliders){
      s.hide();
  }
    for(controlP5.Button b : screen2Buttons){
      b.hide();
  }
    for(controlP5.Button b : fractalScreenButtons){
      b.hide();
  }
    buttonPlayer.rewind();
    buttonPlayer.play();
    title.show();
}
public void Another(int theValue){//Method for Another
    buttonPlayer.rewind();
    buttonPlayer.play();
    superF.randomize();
}
public void New(int theValue) {//Method for New
    screen=2;
    for(controlP5.Button b : buttons){
      b.hide();
  }
    for(controlP5.Slider s : sliders){
      s.show();
  }
    for(controlP5.Button b : screen2Buttons){
      b.show();
  }
    buttonPlayer.rewind();
    buttonPlayer.play();
    title.hide();
}

public double randomRange(double min, double max){//Random Range 
    double range = max - min;
    return ((Math.random()*(max - min) )+ min);
}
public class FractalSuperClass{// FractalSuperClass
    private Fractal f;//class fractal
    private ImageDrawer id;//class imagedrawer
    private FractalGenerator fg;//class fractal generator
    private color[] startImage;
  
    public void init(){
      startImage = new color[height*width];
        for(int i = 0; i < startImage.length;i++){
        startImage[i] = #000000;
    }
    f = new Fractal();
    id = new ImageDrawer();
    //f.addTransform(new Transform(new double[] {0.5 , 0 , 0 , 0.5 , 0 , 0 }));   //Sierpinski Triangle coordinates
    //f.addTransform(new Transform(new double[] {0.5 , 0 , 0 , 0.5 , 0.5 , 0}));
    //f.addTransform(new Transform(new double[] {0.5 , 0 , 0 , 0.5 , 0, .5}));
    //f.randomizeTransforms();
    f.addTransform(new Transform(new double[] {0.010885947493173377, 0.2808992480944827, -0.2808992480944827, 0.010885947493173377, -0.5869918169600727, -0.10870101203681948}));
    f.addTransform(new Transform(new double[] {0.5669942459990576, -0.6271564809872958, 0.6271564809872958, 0.5669942459990576, 0.31982107840169105, 0.8983997164600468}));
    f.addTransform(new Transform(new double[] {-0.3040865909523644, 0.3295798717341891, -0.3295798717341891, -0.3040865909523644, 0.5073588257981578, 0.15114173269304554 }));
    f.addTransform(new Transform(new double[] {0.3044249007100226, -0.20457952976627647, 0.20457952976627647, 0.3044249007100226, 0.8775904622580672, -0.7133548521847513 }));
    f.addTransform(new Transform(new double[] { -0.5124627061554431, -0.35184002463849734, 0.35184002463849734, -0.5124627061554431, 0.8423650647128658, 0.03542727800595813}));
    f.addTransform(new Transform(new double[] { -0.8503561808424932, -0.1322749535463285, 0.1322749535463285, -0.8503561808424932, 0.38314079463504847, 0.6141149031630839}));
    //f.addTransform(new Transform(new double[] {-.467,.02,-.113,.015,.4,.4}));   //Twig
    //f.addTransform(new Transform(new double[] {.387,.43,.43,-.387,.256,.522}));
    //f.addTransform(new Transform(new double[] {.441,-.091,-.009,-.322,.421,.505}));
    
    //                        double theta,double psi,do  uble r,double s,double e,double f
    //f.addTransform(new Transform(0,0,.5,.5,0,0));
    fg = new FractalGenerator(startImage,f);
    fg.setBack(#0066FF);
    fg.setFront(#990033);
    id.setImage(fg.getCurrentImage());
  }
    public Fractal getFractal(){
      return fg.getFractal();
  }
    public FractalGenerator getFG(){
      return fg;
  }
    public void run(){
     if(change){
       randomize();
       change = false;
     }
     fg.applyTransforms();
     id.setImage(fg.getCurrentImage());
     id.drawImage();
     //delay(10000);
  }
    public void randomize(){
       f.randomizeTransforms();
       fg = new FractalGenerator(startImage,f);
       fg.setBack((int)randomRange(-Integer.MAX_VALUE, Integer.MAX_VALUE));
       fg.setFront((int)randomRange(-Integer.MAX_VALUE, Integer.MAX_VALUE));
  }
  
}
public class FractalGenerator{//class Fractal Generator 
    private color back,front;
    private Fractal current;
    private int iterations;
    private color[] initialImage;  //index in an x,y format
    private color[] currentImage;  //index in an x,y format  
    private color[] newImage;     //index in an x,y format
      FractalGenerator(color[] image){
        back = #ffffff;
        front = #000000;
        initialImage = image.clone();
        currentImage = image.clone();
        newImage = new color[width*height];
        for(int i = 0; i < newImage.length; i++){
        newImage[i] = back;
    }
  }
    public void setFront(color c){
      front = c;
        for(int i = 0; i < initialImage.length; i++){
          initialImage[i] = front;
    }
    reset();
  }
    public void setBack(color c){
      back = c;
  }
    FractalGenerator(color[] image, Fractal f){
      initialImage = image;
      currentImage = image;
      newImage = new color[height*width];
      current = f;
      for(int i = 0; i < newImage.length; i++){
        newImage[i] = back;
    }
  }
    public void reset(){
      currentImage = initialImage.clone();
  }
    public color[] getCurrentImage(){
      return currentImage.clone();
  }
    public void generateFractal(){
      reset();
        for(int i = 0; i < iterations; i++){
          applyTransforms();
    }
  }
    private color[] imageUnion(color[] arr1arg, color[] arr2arg){
      color[] arr1 = arr1arg.clone();
      color[] arr2 = arr2arg.clone();
      for(int i = 0; i < arr1.length; i++){
         if(arr2[i] != back){
           arr1[i] = arr2[i];
     }
    }
      return arr1;
  }
    public void applyTransforms(){
      color[] nextImage = new color[width*height];
      for(int i = 0; i < nextImage.length; i++){
      nextImage[i] = back;
    }
      for(Transform t : current.getTransforms()){
        applyTransform(t);
        nextImage = imageUnion(nextImage,newImage);
    }
    currentImage = nextImage;
  }
  
  /*
   * F(x,y) = (a*x + b*y + e, c*x + d*y + f)
   *  a = r*cos(theta), b = -s*sin(psi), c = r*sin(theta), d = s*cos(psi)
   */
   //Sets the value of newimage to the affine linear mapping of currentImage
  private void applyTransform(Transform t){
    for(int i = 0; i < newImage.length; i++){
      newImage[i] = back;
    }
    double[] matrix = t.getMatrix();
    
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        int currentIndex = x + (width*y);
        
        if(currentImage[currentIndex] != back){
          int newIndex = (int)(Math.round( (matrix[0]*x + matrix[1]*y) + (matrix[4]*width)) + (Math.round(matrix[2]*x + matrix[3]*y + (matrix[5]*height))*width));
          if(newIndex < newImage.length && newIndex >= 0){
            newImage[newIndex] = currentImage[currentIndex];  //May have to fix rounding by adding in support for changing scale 
          }
        }
      }
    }
  }
  
  public Fractal getFractal() {
    return current;
  }
  public void setFractal(Fractal current) {
    this.current = current;
  }
  public long getIterations() {
    return iterations;
  }
  public void setIterations(int iterations) {
    this.iterations = iterations;
  }
  public color[] getInitialImage() {
    return initialImage.clone();
  }
  public void setInitialImage(color[] initialImage) {
    this.initialImage = initialImage.clone();
  }
}

public class ImageDrawer{//ImageDrawer class
  private color[] imageArr;
  PImage p;
  ImageDrawer(){
    p = new PImage(width,height);
    imageArr = new color[width*height];
  }
  ImageDrawer(int[] image){
    imageArr = image.clone();
    p = new PImage(width,height);
  }
  public void drawImage(){
    p.loadPixels();
    p.pixels = imageArr.clone();
    p.updatePixels();
    image(p,0,0);
  }
  public void setImage(color[] newImage){
    imageArr = newImage.clone();
  }
  
  
}
public class Fractal {//class Fractal
  private ArrayList<Transform> transforms;
 
  Fractal(){
    transforms = new ArrayList<Transform>();
  }
  public void addTransform(Transform t){
    transforms.add(t);
   buttonPlayer.rewind();
  buttonPlayer.play();
  }
  public void randomizeTransforms(){
    int numTransforms = (int)(Math.random()*5) + 3;
    //System.out.println("Generating " + numTransforms + " Affine Linear Mappings");
    transforms = new ArrayList<Transform>(numTransforms);
    for(int i = 0; i < numTransforms; i++){
      transforms.add(new Transform());
      //System.out.print("Generated Matrix : ");
      //transforms.get(i).printMatrix();
      //ln();
    }
  }
  public ArrayList<Transform> getTransforms() {
    return transforms;
  }
  public void setTransforms(ArrayList<Transform> transforms) {
    this.transforms = (ArrayList<Transform>) transforms.clone();
  }
}
//stores information for an affine linear mapping
public class Transform{

  private double theta, psi, r , s, e, f;
  private double[] abcdef = new double[6];
  Transform(){
    int rand = (int)Math.random()*4;
    switch(rand){
      case 0 : 
                r = randomRange(.2,.95);
                s = r;
                theta = Math.random() * 2 * Math.PI;
                psi = theta;
                //e = Math.random();
                //f = Math.random();
                break;
      case 1 : 
                r = randomRange(.2,.95);
                s = r;
                theta = Math.PI;
                psi = 0;
                //e = Math.random();
                //f = Math.random();
                break;
      case 2 :  
                r = randomRange(.2,.95);
                s = r;
                theta = 0;
                psi = Math.PI;
                //e = Math.random();
                //f = Math.random();
                break;
      case 3 : 
                r = randomRange(.2,.95);
                s = r;
                theta = Math.PI;
                psi = 0;
                //e = Math.random();
                //f = Math.random();
                break;  
      case 4 :
                r = randomRange(.2,.95);
                s = r;
                theta = Math.random() * 2 * Math.PI;
                psi = theta;
                break; 
    }   
    
    e = randomRange(-1,1);
    f = randomRange(-1,1);
    updateMatrix();
  }
  Transform(double theta,double psi,double r,double s,double e,double f)
  {
    this.setTheta(theta);
    this.setPsi(psi);
    this.setR(r);
    this.setS(s);
    this.setE(e);
    this.setF(f);
    updateMatrix();
  }
  Transform(double[] matrix){
    abcdef = matrix.clone();
  }
  public String toString(){
    String str = "";
    for(int i = 0; i < abcdef.length; i++){
      str+=(abcdef[i] + " ");
    }
    return str;
  }
  public void printMatrix(){
    for(int i = 0; i < abcdef.length; i++){
      System.out.print(abcdef[i] + " ");
    }
  }
  
  public void updateMatrix(){
      /*
   * F(x,y) = (a*x + b*y + e, c*x + d*y + f)
   *  a = r*cos(theta), b = -s*sin(psi), c = r*sin(theta), d = s*cos(psi)
   */
   abcdef[0] = r*Math.cos(theta);
   abcdef[1] = -s*Math.sin(psi);
   abcdef[2] = r*Math.sin(theta);
   abcdef[3] = s*Math.cos(psi);
   abcdef[4] = e;
   abcdef[5] = f;
  }
  public double[] getMatrix(){
    return abcdef.clone();
  }
  public void setMatrix(double[] matrix){
    abcdef = matrix.clone();
  }
    
  public double getF() {
    return f;
  }

  public void setF(double f) {
    this.f = f;
  }

  public double getR() {
    return r;
  }

  public void setR(double r) {
    this.r = r;
  }

  public double getTheta() {
    return theta;
  }

  public void setTheta(double theta) {
    this.theta = theta;
  }

  public double getS() {
    return s;
  }

  public void setS(double s) {
    this.s = s;
  }

  public double getPsi() {
    return psi;
  }

  public void setPsi(double psi) {
    this.psi = psi;
  }

  public double getE() {
    return e;
  }

  public void setE(double e) {
    this.e = e;
  }

}