/**
 * 
 */
package ch.ethz;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.util.StringTokenizer;

import sun.net.www.http.HttpClient;

/**
 * @author prasad
 *
 */
public class ServerThread extends Thread{
	
	Socket client;
	BufferedInputStream in;
	DataOutputStream out;

	/**
	 * 
	 */
	public ServerThread(Socket client) {
		// TODO Auto-generated constructor stub
		
		
		this.client = client;
	
	}
	
	
	public void run() {
		try {
			in = new BufferedInputStream(client.getInputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		try {
			out = new DataOutputStream(client.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		handleIncomingRequest();
	}


	/**
	 * 
	 */
	private void handleIncomingRequest() {
		// TODO Auto-generated method stub
		
		BufferedReader r = new BufferedReader( new InputStreamReader(in, StandardCharsets.UTF_8));
	
		String request = null;
		try {
			request = r.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			decodeRequest(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}


	/**
	 * @throws Exception 
	 * 
	 */
	private void decodeRequest(String request) throws Exception {
		print(request);
		 tokens = new StringTokenizer(request);
		 rqeustType = tokens.nextToken();
		 rqeustQuery = tokens.nextToken();
		 System.out.println("rqeustType = "+rqeustType);
		 System.out.println("rqeustQuery = "+rqeustQuery);
		 
		 
		 if(rqeustType.equals("GET")) {
			 if(rqeustQuery.equals("/")){
					sendResponse(HttpURLConnection.HTTP_ACCEPTED, HttpConstants.HTML_BEGIN + "<form enctype=\"multipart/form-data\" method=\"post\" action=\"\"> <label>Choose a zip file to upload: <input type=\"file\" name=\"zip_file\" /></label>"
					 +"<br/><input type=\"submit\" name=\"submit\" value=\"Upload\" /></form>" +  HttpConstants.HTML_END );
				
			 } else {
				 sendResponse(HttpURLConnection.HTTP_NOT_FOUND, HttpConstants.PAGE_NOT_FOUND_STRING);   
			 
			 }
		 } else if(rqeustType.equals("POST")) {
			 if(rqeustQuery.equals("/")){
			}
		 }
		
		 
	}
	
	/**
	 * @param httpNotFound
	 * @param pAGE_NOT_FOUND_STRING
	 */
	private void sendResponse(int respCode, String respStr) throws Exception{
		// TODO Auto-generated method stub
		String responseType = "Content-Type: text/html" + "\r\n";
		
		if(respCode == HttpURLConnection.HTTP_ACCEPTED){
			
		}else if(respCode == HttpURLConnection.HTTP_NOT_FOUND){
			
		}
		
		 if (respCode == 200)
			 out.writeBytes("HTTP/1.1 200 OK" + "\r\n");
			else
				out.writeBytes("HTTP/1.1 404 Not Found" + "\r\n");
		out.writeBytes("Content-Type: text/html" + "\r\n");
		out.writeBytes(respStr.length() +"");
		out.writeBytes("Connection: close\r\n");
		out.writeBytes("\r\n");
		
		out.writeBytes(respStr);
		out.close();
	}


	/**
	 * 
	 */
	private void print(String request) {
		
		// TODO Auto-generated method stub
		System.out.println("/********Request received by server*********/");
		
		System.out.println("Client ip = "+client.getInetAddress());
		System.out.println("Client port = "+client.getPort());
		System.out.println("Incoming request = "+request);
		
		System.out.println("/*******************************************/");
	}
	
	StringTokenizer tokens = null;
	String rqeustType = null;
	String rqeustQuery = null;

}
