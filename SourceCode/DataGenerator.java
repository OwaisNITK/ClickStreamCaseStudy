package com.click.stream.dataset.generator;

import java.sql.Time;
import java.util.Random;

import com.click.stream.dataset.template.ClickStreamDataModel;

// TODO: Auto-generated Javadoc
/** The Class DataGenerator. */
public class DataGenerator {

    /** The Constant random. */
    private static final Random random = new Random();

    /** The Constant actions. */
    private static final String[] actions = { "view", "addtocart", "removefromcart", "checkout" };

    /** The Constant locations. */
    private static final String[] locations = { "delhi", "mumbai", "bangalore", "hyderabad", "chennai", "indore", "ahemadabad" };

    /** The Constant paymentMethods. */
    private static final String[] paymentMethods = { "creditcard", "debitcard", "netbanking", "paypal" };

    /** Generate random data.
     *
     * @param date
     *            the date
     * @return the string */
    public String generateRandomData(String date) {
        ClickStreamDataModel dto = new ClickStreamDataModel();
        dto.setUserId(String.valueOf(generateRandomInteger(1, 1000)));
        dto.setAction(actions[generateRandomInteger(0, actions.length - 1)]);
        dto.setLocation(locations[generateRandomInteger(0, locations.length - 1)]);
        dto.setLogDate(date);
        dto.setLogTime(generateRandomTime());
        generateUrl(dto).toString();
        return dto.toString();
    }

    /** Generate url.
     *
     * @param dto
     *            the dto
     * @return the click stream data model */
    public ClickStreamDataModel generateUrl(ClickStreamDataModel dto) {
        if (dto.getAction().equalsIgnoreCase("view")) {
            dto.setUrl("/products/" + dto.getAction());
            return dto;
        } else if (dto.getAction().equalsIgnoreCase("addtocart") || dto.getAction().equalsIgnoreCase("removefromcart")) {
            dto.setUrl("/cart/" + dto.getAction());
            return dto;
        } else if (dto.getAction().equalsIgnoreCase("checkout")) {
            dto.setPaymentMethod(paymentMethods[generateRandomInteger(0, paymentMethods.length - 1)]);
            dto.setUrl("/checkout/" + dto.getPaymentMethod());
            return dto;
        }

        return null;
    }

    /** Generate random integer.
     *
     * @param min
     *            the min
     * @param max
     *            the max
     * @return the int */
    public int generateRandomInteger(int min, int max) {
        return random.nextInt((max - min) + 1) + min;
    }

    /** Generate random time.
     *
     * @return the string */
    public static String generateRandomTime() {
        final int millisInDay = 24 * 60 * 60 * 1000;
        Time time = new Time((long) random.nextInt(millisInDay));
        return time.toString();
    }
}