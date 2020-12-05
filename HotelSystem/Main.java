import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scnr = new Scanner(System.in);
        int totalNumOfRooms = 10;
        int numOfRoomsAvaliable = 10;
        int menuOption = 0;

        Room[] hotelRooms = new Room[totalNumOfRooms];

        System.out.println("Welcome to IslandHotel.com");

        while (menuOption != 4) {
            System.out.println("Would you like to:\n" +
                "1) Check Availability\n" +
                "2) Make A Reservation\n" +
                "3) Cancel A Previous Reservation\n" +
                "4) Exit");
            menuOption = scnr.nextInt();

            switch (menuOption) {
                case 1:
                System.out.println(numOfRoomsAvaliable);
                    break;
                case 2:
                    int checker = 0;
                    int roomNumber = 0;
                    while (checker == 0) {
                        System.out.print("What room number would you like?");
                        roomNumber = scnr.nextInt();

                        if (numOfRoomsAvaliable == totalNumOfRooms) {
                            checker = 1;
                        } else {

                            for (int x = 0; x < (totalNumOfRooms - numOfRoomsAvaliable); x++) {
                                if (roomNumber == hotelRooms[x].getRoomNumber()) {
                                    System.out.println("I'm sorry. That room is not available. " +
                                            "Please try a different room number");
                                    checker = 0;
                                    break;
                                } else {
                                    checker = 1;
                                }
                            }
                        }
                    }
                    numOfRoomsAvaliable--;

                    System.out.println("Please enter a last name for the reservation");
                    String lastName = scnr.next();

                    Room newRoom = new Room(roomNumber, lastName);
                    hotelRooms[9 - numOfRoomsAvaliable] = newRoom;

                    break;
                case 3:
                    break;
                default:
                    break;
            }
        }
    }
}
