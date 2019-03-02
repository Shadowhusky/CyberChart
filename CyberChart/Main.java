public class Main {

    private QuickSort quickSort;

    public static void main(String[] args)
    {
        new Main().run();
    }

    public void run()
    {
        NumberGenerator numberGenerator=new NumberGenerator(0,100000000,10000000);
        quickSort=new QuickSort(numberGenerator.gennerate());
        int[] sortedArray=quickSort.quicksort();
        for (int element:
             sortedArray) {
        
            System.out.println(element);
        }
    }
}
