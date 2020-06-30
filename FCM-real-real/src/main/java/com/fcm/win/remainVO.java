package com.fcm.win;

public class remainVO {
	
	public String name_a;
	public String name_b;
	public String name_c;
	public String name_d;
	public String name_e;
	
	public static int remain_a;
	public static int remain_b;
	public static int remain_c;
	public static int remain_d;
	public static int remain_e;
	
	public void setaName(String a) {
		this.name_a = a;
	}
	public void setbName(String a) {
		this.name_b = a;
	}
	public void setcName(String a) {
		this.name_c = a;
	}
	public void setdName(String a) {
		this.name_d = a;
	}
	public void seteName(String a) {
		this.name_e = a;
	}
	
	public static int getA() {
		return remain_a;
	}
	
	public int getB() {
		return remain_b;
	}
	
	public int getC() {
		return remain_c;
	}
	
	public int getD() {
		return remain_d;
	}
	
	public int getE() {
		return remain_e;
	}
	
	public static void setA(int remain) {
		remainVO.remain_a = remain;
	}
	
	public static void setB(int remain) {
		remainVO.remain_b = remain;
	}
	
	public static void setC(int remain) {
		remainVO.remain_c = remain;
	}
	
	public static void setD(int remain) {
		remainVO.remain_d = remain;
	}
	
	public static void setE(int remain) {
		remainVO.remain_e = remain;
	}
	
}
