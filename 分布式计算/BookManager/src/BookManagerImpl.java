import java.io.*;
import java.util.*;
import java.io.Serializable;
import java.rmi.RemoteException;
class Book implements Serializable{
    private int Book_ID;
    private String Book_Name;
    public Book(int ID,String name){
        this.Book_ID=ID;
        this.Book_Name=name;
    }
    public int getID(){
        return Book_ID;
    }
    public String getName(){
        return Book_Name;
    }
    public String showInfo(){
        System.out.println("ID: " + Book_ID
                + " name:" + Book_Name + "\n");
        return "ID: " + Book_ID
                + " name:" + Book_Name + "\n";
    }
}
class BookList implements Serializable {
    ArrayList<Book> booklist = new ArrayList<Book>();

    public String showInfo() {
        String info ="";
        for (int i = 0; i < booklist.size(); i++) {
            info += ("ID: " + booklist.get(i).getID()
                    + " name:" + booklist.get(i).getName() + "\n");
        }
        System.out.println(info);
        return info;
    }
}
public class BookManagerImpl extends java.rmi.server.UnicastRemoteObject implements BookInterface{
    BookManagerImpl() throws RemoteException  {
        super();
    }
    ArrayList<Book> books = new ArrayList<Book>();
    BookList query = new BookList();
    public boolean add(Book b) throws RemoteException, FileNotFoundException{
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).getID() == b.getID()) {
                return false;
            }
        }
        books.add(b);
        return true;
    }
    public Book queryByID(int bookID) throws RemoteException{
        Book b = null;
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).getID() == bookID) {
                b = books.get(i);
                return b;
            }
        }
        return null;
    }

    public BookList queryByID(String name) {
        return null;
    }

    public BookList queryByName(String name) throws RemoteException{
        for (int i = 0; i < books.size(); i++) {
            if(books.get(i).getName().indexOf(name)!=-1){
                query.booklist.add(books.get(i));
            }
        }
        return query;
    }
    public boolean delete(int bookID) throws RemoteException, FileNotFoundException {
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).getID() == bookID) {
                books.remove(books.get(i));
                return true;
            }
        }
        return false;
    }
    public String booksInfo() throws RemoteException {
        String info = "********current books**********\n";
        for (int i = 0; i < books.size(); i++) {
            info += ("ID: " + books.get(i).getID()
                    + " name:" + books.get(i).getName() + "\n");
        }
        return info;
    }
    public void showAllTheBooks() throws RemoteException {
        System.out.println(booksInfo());
    }
}
