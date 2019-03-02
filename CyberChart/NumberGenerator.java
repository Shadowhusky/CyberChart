 import java.util.ArrayList;

public class NumberGenerator {
    int min, max,amount;

    NumberGenerator(int min, int max, int amount)
    {
        this.min = min;
        this.max = max;
        this.amount=amount;
    }

    public int[] gennerate()
    {
        int[] randomNumber=new int[amount];
        for (int i = 0; i < amount; i++) {
            randomNumber[i]=((int)(Math.random()*(max - min))+ min);
        }
        return randomNumber;
    }
}
