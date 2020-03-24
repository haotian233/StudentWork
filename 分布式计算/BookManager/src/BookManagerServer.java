import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
public class BookManagerServer {
    public static void main(String[] args) throws Exception {

        try {
            String name = "BookManager";
            BookInterface engine = (BookInterface) new BookManagerImpl();
            //BookInterface skeleton = (BookInterface) UnicastRemoteObject.exportObject(engine, 0);
            LocateRegistry.createRegistry(1099);
            Naming.bind("rmi://localhost:1099/BookInterface",engine);
            System.out.println("Server Is Running");
        } catch (Exception e) {
            System.err.println("Exception:" + e);
            e.printStackTrace();
        }
    }
}
