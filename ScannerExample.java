// import java.util.*;

// public class PasswordGenerator2 {
//     public static void main(String[] args) {
//         int leftLimit = 48; // numeral '0'
//         int rightLimit = 122; // letter 'z'
//         int targetStringLength = 10;
//         Random random = new Random();
//         String generatedString = random.ints(leftLimit, rightLimit + 1)
//             .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
//             .limit(targetStringLength)
//             .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
//             .toString();
//         System.out.println(generatedString);
//         pw = generatedString.toCharArray();
//         System.out.println("NewPass: " + pw);
//     }
// }

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ScannerExample {
    public static void main(String[] args) {
        boolean run = true;
        try (Scanner sc = new Scanner(System.in)) {
            while (run) {

                System.out.println("Another action? [Y/N]");
                String option = sc.next();
                Pattern patter = Pattern.compile("[YyNn]");
                Matcher m = patter.matcher(option);
                while (!m.matches()) {
                    System.out.println("Incorrect input");
                    option = sc.next();
                    m = patter.matcher(option);
                }
                option = sc.next();
                if (option.toLowerCase().equals("f")) {
                    run = false;
                }

            }
        } catch (Exception e) {
            // TODO: handle exception
        }
    }
}
