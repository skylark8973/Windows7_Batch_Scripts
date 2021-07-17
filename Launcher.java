import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;

import javax.swing.JFrame;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;

public class Launcher extends JFrame {
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
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                Console console = new Console();
                console.init();
                Launcher launcher = new Launcher();
                launcher.setVisible(true);
                console.getFrame().setLocation(
                        launcher.getX() + launcher.getWidth()
                                + launcher.getInsets().right, launcher.getY());
                System.out.println("Started Launcher...");
            }
        });
    }

    private Launcher() {
        super("DevCity13 - Launcher (Alpha)");
        setSize(600, 600);
        setResizable(false);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }
}
