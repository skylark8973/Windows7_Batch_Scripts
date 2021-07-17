import java.awt.*;
import java.util.*;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;

import javax.swing.JFrame;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;

import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;

public class PasswordGenerator3 extends JFrame {

    private static final long serialVersionUID = 1L;

    private static class Console {
        private final JFrame frame;

        public Console() {
            frame = new JFrame();
            final JTextArea textArea = new JTextArea(24, 80);
            textArea.setBackground(Color.BLACK);
            textArea.setForeground(Color.LIGHT_GRAY);
            textArea.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
            System.setOut(new PrintStream(new OutputStream() {

                @Override
                public void write(int b) throws IOException {
                    textArea.append(String.valueOf((char) b));
                }
            }));
            frame.add(textArea);
        }

        public void init() {
            frame.pack();
            frame.setVisible(true);
        }

        public JFrame getFrame() {
            return frame;
        }
    }

    public static void main(String[] args) {
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 15;
        Random random = new Random();
        String generatedString = random.ints(leftLimit, rightLimit + 1)
            .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
            .limit(targetStringLength)
            .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
            .toString();
        StringSelection stringSelection = new StringSelection(generatedString);
        Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
        clipboard.setContents(stringSelection, null);

        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                Console console = new Console();
                console.init();
                PasswordGenerator3 launcher = new PasswordGenerator3();
                launcher.setVisible(true);
                console.getFrame().setLocation(
                        launcher.getX() + launcher.getWidth()
                                + launcher.getInsets().right, launcher.getY());
                System.out.println("Type Ctrl+V to paste the new pswd!");
            }
        });
    }

    private PasswordGenerator3() {
        super("PasswordGenerator3");
        setSize(600, 600);
        setResizable(false);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }
}
