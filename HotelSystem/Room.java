public class Room {
    private int roomNumber;
    private String lastName;

    public Room(int _roomNumber, String _lastName) {
        roomNumber =_roomNumber;
        lastName = _lastName;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public String getLastName() {
        return lastName;
    }
}
