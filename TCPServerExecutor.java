import java.util.*;
import java.net.*;
import java.io.*;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

class TCPThread implements Runnable {
    Socket clientSocket=null;
    public TCPThread(Socket clientSocket){
        this.clientSocket=clientSocket;
    }
    public void run(){
        try{
            InputStream inStream = clientSocket.getInputStream();
            OutputStream outStream = clientSocket.getOutputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(inStream));
            PrintWriter out = new PrintWriter(outStream);
            String line = null;
            while((line=in.readLine())!=null) {
                System.out.println("Message from client:" + line);
                out.println(line);
                out.flush();
            }
            clientSocket.close();
        }
        catch(IOException e){
            e.printStackTrace();
        }

    }

}
public class TCPServerExecutor {
    public static void main(String[] args)throws Exception{
        ThreadPoolExecutor TCPThreadPool=new ThreadPoolExecutor(5,10,200, TimeUnit.MILLISECONDS,new ArrayBlockingQueue<Runnable>(5));
        Socket clientSocket = null;
        ServerSocket listenSocket = new ServerSocket(8188);
        System.out.println("Server is running");
        while(true){
            clientSocket=listenSocket.accept();
            TCPThread task=new TCPThread(clientSocket);
            TCPThreadPool.execute(task);
            System.out.println("The number of thread in the ThreadPool:"+TCPThreadPool.getPoolSize());
            System.out.println("The number of thread in the Queue:"+TCPThreadPool.getQueue());

        }
    }
}
