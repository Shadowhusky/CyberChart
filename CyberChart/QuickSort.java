public class QuickSort
{
    private int pivot;
    private int[] array;
    private static int length;
    public int numberOfComparison_Qck;

    QuickSort(int[] unsortedArray) throws NullPointerException
    {
        array=unsortedArray;
        this.length=array.length;
        numberOfComparison_Qck=0;
    }

    public int[] quicksort()
    {
        return quickSort(0,array.length-1);
    }
    public int[] quickSort(int low, int high)
    {
        if(low < high)
        {
            pivot=partition(low,high);
            quickSort(low,pivot-1);
            quickSort(pivot+1,high);
        }
        numberOfComparison_Qck+=1;
        return array;
    }
    public int partition(int low, int high ) {
        int i=low-1;
        for (int j = low; j < high ; j++) {
            if(array[j]<array[high])
            {
                i++;
                array=swap(i,j);
            }
            numberOfComparison_Qck+=2;
        }
        swap(i+1,high);
        return i+1;
    }

    public int[] swap(int index_1, int index_2)
    {
        numberOfComparison_Qck++;
        
        int temp=array[index_1];
        array[index_1]=array[index_2];
        array[index_2]=temp;
        return array;
    }


}
