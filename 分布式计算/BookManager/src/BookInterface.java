import java.io.FileNotFoundException;
import java.rmi.RemoteException;
import java.rmi.Remote;
public interface BookInterface extends java.rmi.Remote {
    boolean add(Book k) throws RemoteException, FileNotFoundException;//添加书本
    Book queryByID(int BookID) throws RemoteException;//根据ID查询
    BookList queryByName(String BookName) throws RemoteException;//根据书名查询
    boolean delete(int BookID) throws RemoteException, FileNotFoundException; //删除图书

}
