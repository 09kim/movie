package com.movie_admin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.movie_admin.dao.MemberDAO;
import com.movie_admin.vo.MemberBean;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDAO;
	
	@Override
	public List<MemberBean> getMember() {
		
		return memberDAO.getMember();
	}

}
