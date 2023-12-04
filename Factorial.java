class Factorial {
    public static void main(String[] args) {
        long sum = 0;
        long result = 0;

        for (int i = 0; i < 10; i++) {
            long startTime = System.currentTimeMillis();

            for (long j = 0; j < 3628800; j++) {
                for (int k = 1; k <= 20; k++) {
                    result = factorial(k);
                }
            }

            long endTime = System.currentTimeMillis();
            sum += endTime - startTime;
        }

        long avgExecutionTime = sum / 10;

        System.out.println("Factorial result: " + result);
        System.out.println("Average execution time: " + avgExecutionTime + " milliseconds");
    }

    private static long factorial(int n) {
        if (n == 0 || n == 1) {
            return 1;
        } else {
            return n * factorial(n - 1);
        }
    }
}