package com.click.stream.dataset.generator;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;

import org.apache.commons.io.FileUtils;

// TODO: Auto-generated Javadoc
/** The Class ClickStreamFileUtils. */
public class ClickStreamFileUtils {

    /** Write to file.
     *
     * @param data
     *            the data
     * @param absolutePath
     *            the absolute path
     * @return true, if successful
     * @throws IOException
     *             Signals that an I/O exception has occurred. */
    public static boolean writeToFile(String data, String absolutePath) throws IOException {
        File myFile = new File(absolutePath);
        // check if file exist, otherwise create the file before writing
        if (!myFile.exists()) {
            myFile.createNewFile();
            System.out.println("file successfully created on the specified path : " + absolutePath);
        }

        FileUtils.write(myFile, data, Charset.defaultCharset(), true);
        System.out.println("File Writing Completed");
        return true;
    }

    /** Read from file.
     *
     * @param absolutePath
     *            the absolute path
     * @return the string
     * @throws IOException
     *             Signals that an I/O exception has occurred. */
    public static String readFromFile(String absolutePath) throws IOException {
        String jsonString;
        File file = FileUtils.getFile(absolutePath);
        jsonString = FileUtils.readFileToString(file, Charset.defaultCharset());
        return jsonString;
    }
}