/**
 * ExtractRotate.java
 *
 * Copyright (C) 2007 by Heiko Oberdiek <heiko.oberdiek at googlemail.com>
 *
 * Requires: PDFBox (http://www.pdfbox.org/)
 *
 * Syntax: java ExtractRotate <pdffile> <textfile>
 *
 * The <pdffile> is analyzed and for each page its rotation
 * setting is printed in the <textfile>. Example:
 *   /Page 1 /Rotate 0
 *   /Page 2 /Rotate 90
 */
import java.io.FileInputStream;
import java.io.FileWriter;
import org.pdfbox.pdfparser.PDFParser;
import org.pdfbox.pdmodel.PDDocument;
import org.pdfbox.pdmodel.PDDocumentCatalog;
import org.pdfbox.pdmodel.PDPage;

public class ExtractRotate {

    public static void main(String[] args) {
        try {
            String infile = args[0];
            String outfile = args[1];
            FileWriter out = new FileWriter(outfile);
            PDFParser parser =
                    new PDFParser(new FileInputStream(infile));
            parser.parse();
            PDDocument document = parser.getPDDocument();
            PDDocumentCatalog catalog = document.getDocumentCatalog();
            int i = 0;
            for (Object page: catalog.getAllPages()) {
                i++;
                out.write("/Page " + i + " " + "/Rotate "
                        + ((PDPage)page).findRotation() + "\n");
            }
            document.close();
            out.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}
