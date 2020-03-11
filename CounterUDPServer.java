import java.net.*;
import java.io.*;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

class CounterThread implements Runnable{
    private int tickets;
    OperatorCounter cou;
    DatagramSocket socket=null;
    DatagramPacket packet = null;
    BlockingQueue <DatagramPacket>outputQueue;
    CounterThread( DatagramSocket socket,DatagramPacket packet,OperatorCounter cou,BlockingQueue <DatagramPacket>outputQueue){
        this.socket=socket;
        this.packet=packet;
        this.cou=cou;
        this.outputQueue=outputQueue;
    }
    public void run(){
        //System.out.println("Thread");
        String mes=null;
        InetAddress ip=null;
        byte operator;
        Double num1,num2;
        int serverPort=packet.getPort();//返回端口由client指定，应从packet获得而不是与server端口一致
        String result=null;
        byte[] res=null;
        DatagramPacket backPacket = null;
        try{
            ip = packet.getAddress();
            mes = new String(packet.getData(), 0, packet.getLength());
            String [] spString = mes.split(" ");
            System.out.println(mes);
            //for(String ss:spString){ System.out.println(ss); }
            operator=spString[0].getBytes()[0];
            cou.counter(operator);
            num1=Double.parseDouble(spString[1]);
            num2=Double.parseDouble(spString[2]);
            switch(operator){
                case '+': result=(num1+num2)+" ";
                break;
                case '-': result=(num1-num2)+" ";
                break;
                case '*': result=(num1*num2)+" ";
                break;
                case '/': result=(num1/num2)+" ";
                break;
                default:break;
            }
            res=result.getBytes("UTF-8");
            //System.out.println(result);
            backPacket = new DatagramPacket(res,res.length,ip, serverPort);
            outputQueue.put(backPacket);
            //System.out.println("runned"+ip);
        }
        catch (IOException | InterruptedException e) {  e.printStackTrace(); }
        //catch (InterruptedException e){ e.printStackTrace(); }
        }
    }
 class OperatorCounter{
    private int count_p,count_s,count_m,count_d;
    public OperatorCounter(){
        count_p=0;
        count_d=0;
        count_m=0;
        count_s=0;
    }
    public synchronized void counter(byte operator){
        switch(operator){
            case '+': count_p++; break;
            case '-':count_s++; break;
            case '*':count_m++; break;
            case '/':count_d++; break;
            default:break;
        }
        System.out.println("The + has runned "+count_p +"times");
        System.out.println("The - has runned "+count_s +"times");
        System.out.println("The * has runned "+count_m +"times");
        System.out.println("The / has runned "+count_d +"times");
    }
}
public class CounterUDPServer {
    public static void main(String[] args) throws IOException, InterruptedException {
        DatagramSocket aSocket = new DatagramSocket(6666);
        DatagramPacket packet = null;
        BlockingQueue <DatagramPacket>inputQueue=new LinkedBlockingQueue();
        BlockingQueue <DatagramPacket>outputQueue=new LinkedBlockingQueue();
        System.out.println("Server running");
        byte[] data=null;
        OperatorCounter cou=new OperatorCounter();
        while (true) {
            data = new byte[1024];
            packet = new DatagramPacket(data,data.length);
            aSocket.receive(packet);
            inputQueue.put(packet);
            //System.out.println("nm1");
            Thread thread = new Thread(new CounterThread(aSocket,inputQueue.take(),cou,outputQueue)) ;
            //System.out.println("nm2");
            thread.start();
            aSocket.send(outputQueue.take());
            //Thread.currentThread().sleep(10000);
        }
    }
}
