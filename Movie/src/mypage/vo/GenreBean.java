package mypage.vo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class GenreBean implements MarkGenreBean{
//	코메디/느와르/범죄/드라마/로맨스/스릴러/전쟁/가족/판타지/액션/SF/애니메이션/인물/공포/미스터리/어드벤처
	private int 코메디;
	private int 느와르;
	private int 범죄;
	private int 드라마;
	private int 로맨스;
	private int 스릴러;
	private int 전쟁;
	private int 가족;
	private int 판타지;
	private int 액션;
	private int SF;
	private int 애니메이션;
	private int 인물;
	private int 공포;
	private int 어드벤처;
	private int 미스터리;
	
	public ArrayList<String> getDESC() {
		int count = 0;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("코메디", get코메디());
		map.put("느와르", get느와르());
		map.put("범죄", get범죄());
		map.put("드라마", get드라마());
		map.put("스릴러", get스릴러());
		map.put("전쟁", get전쟁());
		map.put("가족", get가족());
		map.put("판타지", get판타지());
		map.put("액션", get액션());
		map.put("SF", getSF());
		map.put("애니메이션", get애니메이션());
		map.put("인물", get인물());
		map.put("공포", get공포());
		map.put("어드벤처", get어드벤처());
		map.put("미스터리", get미스터리());
		
		List<Map.Entry<String, Integer>> list = new ArrayList<>(map.entrySet());
		
		Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {

			@Override
			public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2) {
				int comparision = (o1.getValue() - o2.getValue()) * -1; 
				
				return comparision == 0 ? o1.getValue().compareTo(o2.getValue()) : comparision;
			}
			
			
		});
		
		ArrayList<String> resultList = new ArrayList<String>();
		for(Iterator<Map.Entry<String, Integer>> iter = list.iterator(); iter.hasNext();) {
			if(count == 3) {
				return resultList;
			}
			Map.Entry<String, Integer> entry = iter.next();
			resultList.add(entry.getKey());
			count++;
		}
		
		return resultList;
	}
	
	
	public int get미스터리() {
		return 미스터리;
	}
	public void set미스터리(int 미스터리) {
		this.미스터리 = 미스터리;
	}
	public int get어드벤처() {
		return 어드벤처;
	}
	public void set어드벤처(int 어드벤처) {
		this.어드벤처 = 어드벤처;
	}
	public int get코메디() {
		return 코메디;
	}
	public void set코메디(int 코메디) {
		this.코메디 = 코메디;
	}
	public int get느와르() {
		return 느와르;
	}
	public void set느와르(int 느와르) {
		this.느와르 = 느와르;
	}
	public int get범죄() {
		return 범죄;
	}
	public void set범죄(int 범죄) {
		this.범죄 = 범죄;
	}
	public int get드라마() {
		return 드라마;
	}
	public void set드라마(int 드라마) {
		this.드라마 = 드라마;
	}
	public int get로맨스() {
		return 로맨스;
	}
	public void set로맨스(int 로맨스) {
		this.로맨스 = 로맨스;
	}
	public int get스릴러() {
		return 스릴러;
	}
	public void set스릴러(int 스릴러) {
		this.스릴러 = 스릴러;
	}
	public int get전쟁() {
		return 전쟁;
	}
	public void set전쟁(int 전쟁) {
		this.전쟁 = 전쟁;
	}
	public int get가족() {
		return 가족;
	}
	public void set가족(int 가족) {
		this.가족 = 가족;
	}
	public int get판타지() {
		return 판타지;
	}
	public void set판타지(int 판타지) {
		this.판타지 = 판타지;
	}
	public int get액션() {
		return 액션;
	}
	public void set액션(int 액션) {
		this.액션 = 액션;
	}
	public int getSF() {
		return SF;
	}
	public void setSF(int SF) {
		this.SF = SF;
	}
	public int get애니메이션() {
		return 애니메이션;
	}
	public void set애니메이션(int 애니메이션) {
		this.애니메이션 = 애니메이션;
	}
	public int get인물() {
		return 인물;
	}
	public void set인물(int 인물) {
		this.인물 = 인물;
	}
	public int get공포() {
		return 공포;
	}
	public void set공포(int 공포) {
		this.공포 = 공포;
	}
	
	
}
