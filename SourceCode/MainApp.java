package com.click.stream.dataset.app;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;

import com.click.stream.dataset.generator.ClickStreamFileUtils;
import com.click.stream.dataset.generator.DataGenerator;
import com.click.stream.dataset.template.DataSetModel;
import com.click.stream.dataset.template.TemplateCreatorService;

// TODO: Auto-generated Javadoc
/** The Class MainApp. */
public class MainApp {

    /** The main method.
     *
     * @param args
     *            the arguments
     * @throws Exception
     *             the exception */
    public static void main(String[] args) throws Exception {

        System.out.println("Date Supplied : " + args[0]);
        System.out.println("Number of records to be generated : " + args[1]);
        System.out.println("Batch Size : " + args[2]);
        System.out.println("Output Directory : " + args[3]);
        System.out.println("......................................");
        System.out.println("Carrying Out Validation of supplied values");

        // Validating Date
        Boolean formatValidation = isValidFormat("dd-MM-yyyy", args[0], Locale.getDefault());
        if (!formatValidation) {
            System.out.println("Date Format does not match DD-MM-YYYY. Please Restart the Application");
            System.exit(0);
        }

        // Validating NumberOfRecords
        if (!IsStringValidPositiveInteger(args[1])) {
            System.out.println("Invalid number of records . Please insert a positive integer");
            System.exit(0);
        }

        // Validating Batch Size
        if (!IsStringValidPositiveInteger(args[2])) {
            System.out.println("Invalid Batch Size. Please insert a positive integer");
            System.exit(0);
        }

        String date = args[0];
        int numberOfRecords = Integer.valueOf(args[1]);
        int batchSize = Integer.valueOf(args[2]);
        String directoryPath = args[3];

        // Resolving no of Batches to Run
        int noOfBatches;
        if ((numberOfRecords % batchSize) == 0) {
            noOfBatches = (int) numberOfRecords / batchSize;
        } else {
            noOfBatches = (int) numberOfRecords / batchSize + 1;
        }

        System.out.println("Data Generation would be carried out in " + noOfBatches + " batches");

        // Resolving Output Directory Path
        String fileSeparator = System.getProperty("file.separator");
        directoryPath.replaceAll("/", Matcher.quoteReplacement(fileSeparator));
        String absolutePath = directoryPath + "clickstream" + "_" + date + ".txt";

        long start_time = System.nanoTime();

        TemplateCreatorService templateCreator = new TemplateCreatorService();
        DataSetModel dataset = new DataSetModel();
        List<String> dataList = new ArrayList<String>();
        DataGenerator dataGenerator = new DataGenerator();

        for (int batch = 1; batch <= noOfBatches; batch++) {
            System.out.println("Batch : " + batch + " executing . . .");
            if(batch!=noOfBatches) {
                for (int i = 1; i <= batchSize; i++) {
                    dataList.add(dataGenerator.generateRandomData(date));
                }
            } else {
                for (int i = 1; i <= (numberOfRecords%batchSize); i++) {
                    dataList.add(dataGenerator.generateRandomData(date));
                }
            }

            dataset.setDataList(dataList);
            String data = templateCreator.createTemplate(dataset);

            try {
                ClickStreamFileUtils.writeToFile(data, absolutePath);
            } catch (Exception e) {
                System.out.println("Error while writing file. Please check with file path");
                System.exit(0);
            }
            dataList.clear();
        }

        long end_time = System.nanoTime();
        double difference = ((end_time - start_time) / 1e6) / 1000;
        System.out.println("Data Successfully generated at : " + absolutePath);
        System.out.println("Total Time Taken In Seconds : " + difference);
    }

    /** Checks if is valid format.
     *
     * @param format
     *            the format
     * @param value
     *            the value
     * @param locale
     *            the locale
     * @return true, if is valid format */
    public static boolean isValidFormat(String format, String value, Locale locale) {
        LocalDateTime ldt = null;
        DateTimeFormatter fomatter = DateTimeFormatter.ofPattern(format, locale);

        try {
            ldt = LocalDateTime.parse(value, fomatter);
            String result = ldt.format(fomatter);
            return result.equals(value);
        } catch (DateTimeParseException e) {
            try {
                LocalDate ld = LocalDate.parse(value, fomatter);
                String result = ld.format(fomatter);
                return result.equals(value);
            } catch (DateTimeParseException exp) {
                try {
                    LocalTime lt = LocalTime.parse(value, fomatter);
                    String result = lt.format(fomatter);
                    return result.equals(value);
                } catch (DateTimeParseException e2) {
                    // Suppress any Validation Error and return false
                }
            }
        }

        return false;
    }

    /** Checks if is string valid positive integer.
     *
     * @param number
     *            the number
     * @return true, if successful */
    public static boolean IsStringValidPositiveInteger(String number) {
        try {
            Integer.parseInt(number);
        } catch (NumberFormatException ne) {
            return false;
        }

        if (Integer.valueOf(number) < 0) {
            return false;
        }

        return true;
    }
}