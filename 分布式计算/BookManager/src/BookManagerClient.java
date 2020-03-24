import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.*;
import java.io.*;
import java.net.ConnectException;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.io.Serializable;
public class BookManagerClient {
    public static void main(String args[]) throws RemoteException, NotBoundException, FileNotFoundException, MalformedURLException {
        //String name="BookManager";
       // String serverIP = "127.0.0.1";
        //int serverPort = 1099;
        //Registry registry = LocateRegistry.getRegistry(serverIP, serverPort);
        //BookInterface BM = (BookInterface) registry.lookup(name);
        BookInterface BM = (BookInterface) Naming.lookup("rmi://localhost:1099/BookInterface");
        Scanner input = new Scanner(System.in);
        System.out.println(menu());
        int choose = input.nextInt();
        while(choose!=0){
            switch (choose) {
                case 1:
                    System.out.println("please input book_id and book_name to add it\n");
                    int newBookID = input.nextInt();
                    String newName = input.next();
                    Book newBook = new Book(newBookID, newName);
                    if (BM.add(newBook)) {
                        System.out.println("add sucessful\n");
                    } else {
                        System.out.println("ID:" + newBookID + " pre_existing, add book failed\n");
                    }
                    break;
                case 2: System.out.println("please input book_id to query it\n");
                    int queryBookID = input.nextInt();
                    Book queryid = BM.queryByID(queryBookID);
                    if (queryid != null) {
                        System.out.println("*******book list *********\n");
                        queryid.showInfo();
                    } else {
                        System.out.println("this book isnot existing");
                    }
                    break;
                case 3: System.out.println("please input book_name to query it\n");
                    String queryBookKeyword = input.next();
                    BookList list = BM.queryByName(queryBookKeyword);
                    if (list != null) {
                        System.out.println("*******book list *********\n");
                        list.showInfo();
                    } else {
                        System.out.println("this book isnot existing");
                    }
                    break;
                case 4: System.out.println("please input book_id to delete it\n");
                    int deleteID = input.nextInt();
                    if (BM.delete(deleteID)) {
                        System.out.println("del sucessful\n");
                    } else {
                        System.out.println("del failed\n");
                    }
                    break;
                default: System.out.println("please input again!\n");
                    break;
            }
            System.out.println(menu());
            choose=input.nextInt();
        }
    }
    public static String menu() {
        return "**********menu**********\n"
                + "1.add book\n"
                + "2.query Book by ID\n"
                + "3.query Book By Name\n"
                + "4.delete Book by ID\n"
                + "0.quit\n"
                + "************************\n";
    }
}
