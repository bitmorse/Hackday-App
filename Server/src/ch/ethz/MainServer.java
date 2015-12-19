package ch.ethz;

import java.io.IOException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.UnknownHostException;

/**
 * 
 */

/**
 * @author prasad
 *
 */
public class MainServer {

	/**
	 * 
	 */
	public MainServer() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		ServerSocket ssocket = null;
		try {
			ssocket = new ServerSocket(22000);
			printServerDetails(ssocket);
			
//			ssocket.accept();
		
		
		while (running){
			   new ServerThread(ssocket.accept()).start();
		}
	
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			running = false;
		}

	}

	/**
	 * @param ssocket
	 */
	private static void printServerDetails(ServerSocket socket) {
		System.out.println("/********SERVER STARTED*********/");
		InetAddress IP = null;
		try {
			IP = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("IP of Server is := " + IP.getHostAddress());
		System.out.println("Server getInetAddress- "
				+ socket.getInetAddress());
		System.out.println("Server LocalSocketAddress- "
				+ socket.getLocalSocketAddress());
		System.out
				.println("Server LocalPort- " + socket.getLocalPort());
		System.out.println("/*******************************/");
	}
	
	
	static boolean running = true;
	
	

}
