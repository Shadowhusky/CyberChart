int[] sortedArray;
int amount;
int M=1000000;
int Counter=0;
int x_Shift=100;
int y_Shift=50;
int savedImage=1;
int scaleSize=10;
int totalImage=2;
int valueMax=10000000;
int valueMin=100000;
int interval=M;
int imageIndex=1;
int numOfPoints;
float[] xData;
float[] yData;
final int max=10000000;
final int min=0;

float[] new_X=new float[2];
float[] new_Y=new float[2];
float[] old_X=new float[2];
float[] old_Y=new float[2];
float[][][] savedX;
float[][][] savedY;

String xTag="Amount";
String yTag="Comparison";

QuickSort quickSort;
HeapSort heapSort;
NumberGenerator numberGenerator;


void setup()
{
  size(1500,1000);
  numOfPoints=(valueMax-valueMin)/interval;
  savedX=new float[totalImage+2][2][numOfPoints+1];
  savedY=new float[totalImage+2][2][numOfPoints+1];
  reDraw();
}

void reDraw()
{
for(int type=0;type<2;type++)
{
 old_X[type]=x_Shift;
 old_Y[type]=1000-y_Shift;
 new_X[type]=0;
 new_Y[type]=0;
}
 amount=valueMin; 
 background(0);
 redraw();
}

void drawAxis()
{
  //Draw indicator
  //Quicksort
  noStroke();
  fill(0,255,0);
  rect(1450,40,30,20);
  textSize(15);
  text("Quicksort:",1370,56);
  //Heapsort
  fill(0,0,255);
  textSize(16);
  text("Heapsort:",1369,85);
  rect(1450,70,30,20);
  
  
  //Draw origin point.
  textSize(20);
  fill(255);
  text("0",x_Shift-20,1000-y_Shift+20);
  stroke(255,255,0);
  fill(0);
  strokeWeight(5);
  
  //X-Axis
  int xAxis_Terminal_X=10*M/M*100+x_Shift+250;
  int xAxis_Terminal_Y=1000-y_Shift;
  int arrowShift=20;//Prevent the overlap of arrow and label.
  line(0+x_Shift,1000-y_Shift,xAxis_Terminal_X+arrowShift,xAxis_Terminal_Y);
  triangle(xAxis_Terminal_X+arrowShift,xAxis_Terminal_Y+5,xAxis_Terminal_X+arrowShift,xAxis_Terminal_Y-5,xAxis_Terminal_X+5+arrowShift,xAxis_Terminal_Y);
  
  //Y-Axis
  int yAxis_Terminal_X=x_Shift;
  int yAxis_Terminal_Y=1000-(950)-30;
  arrowShift=0;
  line(0+x_Shift,1000-y_Shift,yAxis_Terminal_X,yAxis_Terminal_Y-arrowShift);
  triangle(yAxis_Terminal_X,yAxis_Terminal_Y-5-arrowShift,yAxis_Terminal_X-5,yAxis_Terminal_Y-arrowShift,yAxis_Terminal_X+5,yAxis_Terminal_Y-arrowShift);
  
  //X_Label
  for(int i=100;i<xAxis_Terminal_X-100;i+=100)
  {
    textSize(12);
    stroke(0);
    strokeWeight(1);
    line(i+x_Shift,1000-y_Shift,i+x_Shift,yAxis_Terminal_Y);//Repaint the original line.
    stroke(200,40);
    line(i+x_Shift,1000-y_Shift,i+x_Shift,yAxis_Terminal_Y);//Draw mash.
 
    stroke(255,255,0);
    fill(255);
    text(i+"*(10^4)",i+x_Shift-35,1000-y_Shift+20);
    strokeWeight(2);
    line(i+x_Shift,1000-y_Shift-scaleSize,i+x_Shift,1000-y_Shift);//Draw scale.

   
  }
  textSize(20);
  text(xTag,xAxis_Terminal_X+40+arrowShift,1000-y_Shift+7);
  
  //Y_Label
  textSize(12);
  for(int i=100;i<=1000-yAxis_Terminal_Y;i+=100)
  {
    stroke(0);
    strokeWeight(1);
    line(xAxis_Terminal_X,1000-y_Shift-i,x_Shift+4,1000-y_Shift-i);
    stroke(200,40);
    line(xAxis_Terminal_X,1000-y_Shift-i,x_Shift+4,1000-y_Shift-i);//Draw mash.
 
    
    stroke(255,255,0);
    fill(255);
    text(i+"M",x_Shift-50,1000-y_Shift+5-i);
    strokeWeight(2);
    line(x_Shift,1000-y_Shift-i,x_Shift-scaleSize,1000-y_Shift-i);//Draw scale.
  }
  textSize(20);
  text(yTag,yAxis_Terminal_X+20,yAxis_Terminal_Y);
}


void draw()
{
  drawAxis();

  if(savedImage==totalImage&&amount<valueMax)
  {
   drawAverage();
   save("Average.gif");
   return;    
  }
  if(amount<valueMax)
  {
     numberGenerator=new NumberGenerator(min,max,amount);
     int[] randomArray=numberGenerator.gennerate();
     quickSort=new QuickSort(randomArray);
     heapSort=new HeapSort(randomArray);
    
     int numberOfComparison_Qck;
     int numberOfComparison_Heap;
     int[] sortedArray_Qck=quickSort.quicksort();
     int[] sortedArray_Heap=heapSort.heapSort();
     numberOfComparison_Qck=quickSort.numberOfComparison_Qck;
     numberOfComparison_Heap=heapSort.numberOfComparison_Heap;
     //println("HeapSort: "+numberOfComparison_Heap);
     //println("QuickSort: "+numberOfComparison_Qck);
     int oldAmount=amount;
     drawChart(numberOfComparison_Qck,0);
     amount=oldAmount;
     drawChart(numberOfComparison_Heap,1);
  }
  if(amount>=valueMax&&savedImage<totalImage)
  {
   saveGraph(); 
   savedImage++;
   imageIndex++;
   reDraw();
  }

}

void drawAverage()
{
    //Draw the last chart(Average);
  float[] average_Qck=new float[numOfPoints+1];
  float[] average_Heap=new float[numOfPoints+1];
  float temp=0;
  for(int i=1;i<totalImage;i++)
  {
      for(int k=0;k<=numOfPoints;k++)
      {
        average_Qck[k]+=savedY[i][0][k];
        average_Heap[k]+=savedY[i][1][k];
      }
  }
    for(int i=0;i<=numOfPoints;i++)
    {
      average_Qck[i]=average_Qck[i]/(totalImage-1); 
      average_Heap[i]=average_Heap[i]/(totalImage-1); 
    }
  for(int i=0;amount<valueMax;i++) //<>//
  {
    int oldAmount=amount;
    drawChart(average_Qck[i],0);
    amount=oldAmount;
    drawChart(average_Heap[i],1);
    amount+=interval;
    println("amount: " + amount);
  }
}

void saveGraph()
{
 save(savedImage+".gif");
}


void drawChart(float value,int type/*0=qck,1=heap.*/)
{

  
  if(amount==100000)
  {
    new_X[type]=0+x_Shift;
    new_Y[type]=1000-y_Shift;
  }
  else
  {
  new_X[type]=(float)amount/M*100;
  new_Y[type]=(float)(1000-(value/M));
  
    //allign to specific x,y axis.
  new_X[type]+=x_Shift;
  new_Y[type]-=y_Shift;
  }

  if(savedImage==totalImage)
  {
    new_Y[type]=value; 

  }
    println("new_Y: "+new_Y[type]);
  

  savedX[imageIndex][type][(amount-valueMin)/interval]=new_X[type];
  savedY[imageIndex][type][(amount-valueMin)/interval]=new_Y[type];
 
  strokeWeight(5);
  if(type==0)
  {
    stroke(0,255,0,150);//Green line to connect points.
  }
  else
  {
    stroke(0,0,255,150);//Blue line to connect points.
  }
  line(new_X[type],new_Y[type],old_X[type],old_Y[type]);
  stroke(255,0,0,50);
  strokeWeight(5);
  //point(new_X[type],new_Y[type]);
  
  old_X[type]=new_X[type];
  old_Y[type]=new_Y[type];
 
 //Save data which can be used for calculating average and standard deviation.


  if(savedImage<totalImage) amount+=interval;
 
  //Counter++;
}
