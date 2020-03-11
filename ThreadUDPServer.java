import java.io.*;
import java.net.*;
class ThreadServer extends Thread{
    private int tickets;
    DatagramSocket socket=null;
    DatagramPacket packet = null;
    ThreadServer( DatagramSocket socket,DatagramPacket packet){
        this.socket=socket;
        this.packet=packet;
    }
    public void run(){
        String info=null;
        InetAddress ip=null;
        int serverPort=6666;
        byte [] buff=null;
        DatagramPacket backPacket = null;
        try{
            info = new String(packet.getData(), 0, packet.getLength());
            System.out.println("received from client："+info);
            ip = packet.getAddress();
            serverPort = packet.getPort();
            buff = "response".getBytes();
            backPacket = new DatagramPacket(buff, buff.length, ip, serverPort);
                socket.send(backPacket);
        }
        catch (IOException e) {
            e.printStackTrace();
        }

    }
}

public class ThreadUDPServer {
    public static void main(String[] args) throws  IOException{
        DatagramSocket aSocket = new DatagramSocket(6666);
        DatagramPacket packet = null;
        byte [] data=null;
        int count=0;
        System.out.println("Server running");
        while (true) {
            data = new byte[1024];//字节数组，确定数据包大小
            packet = new DatagramPacket(data, data.length);
            aSocket.receive(packet);
            Thread thread = new Thread(new ThreadServer(aSocket, packet));
            thread.start();
            count++;
            System.out.println("the times of the server:" + count);
            InetAddress address = packet.getAddress();
            System.out.println("the ip of the cilient：" + address.getHostAddress());
        }

    }
}
