package fks.servlet;

import java.io.File;

public class CryptoUtilsTest {
	public static void main(String[] args) {
		String key = "XzD51lP0QxgP74wt";
		File inputFile = new File("E:\\plrabn12.txt");
		File encryptedFile = new File("E:\\document.txt");
		File decryptedFile = new File("E:\\dec_document.txt");
		try {
			CryptoUtils.encrypt(key, inputFile, encryptedFile);
			CryptoUtils.decrypt(key, encryptedFile, decryptedFile);
		} catch (CryptoException ex) {
			System.out.println(ex.getMessage());
			ex.printStackTrace();
		}
		finally {
			System.out.println(key.length());
		}
	}
}
