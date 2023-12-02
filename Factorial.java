class Factorial{
    public static void main(String[] args){
        long avg = 0;
        int itr = 10;
        for(int i=0; i< itr; i++){
            long startTime = System.nanoTime();
                for(int j=0; j< 10000; j++){
                    factorial(j);
                }
            long elapsedTime = System.nanoTime() - startTime;
            System.out.println("Execution time in ms: "
                + elapsedTime/1000000);
            avg += elapsedTime;
        }
        avg = avg/itr;

        System.out.println("Avg execution time in ms: "
                + avg/1000000);
    }
    private static long factorial(int n) {
        if (n == 0 || n == 1) {
            return 1;
        } else {
            return n * factorial(n - 1);
        }
    }
}