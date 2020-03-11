import java.net.*;
import java.io.*;
import java.util.Scanner;

public class CounterUDPClient {
    public static void main(String args[]){
// args give message contents and server hostname
        DatagramSocket aSocket = null;
        try {
            aSocket = new DatagramSocket();
            Scanner scan = new Scanner(System.in);
            String info = scan.nextLine();
            byte[] m=null;
            m=info.getBytes();
            InetAddress aHost = InetAddress.getByName(null);
            int serverPort = 6666;
            DatagramPacket request = new DatagramPacket(m, m.length, aHost, serverPort);
            //System.out.println("received0");
            aSocket.send(request);
            //System.out.println("received1");
            byte[] buffer = new byte[1024];
            //System.out.println("received2");
            DatagramPacket reply = new DatagramPacket(buffer, buffer.length);
            //System.out.println("received3"+aHost);
            aSocket.receive(reply);
            System.out.println("The Result Is: " + new String(reply.getData()));
        } catch (SocketException e){
            System.out.println("Socket: " + e.getMessage());
        } catch (IOException e){
            System.out.println("IO: " + e.getMessage());
            System.out.println("OK");
        }  finally {
            if(aSocket != null) aSocket.close();
        }
    }
}
