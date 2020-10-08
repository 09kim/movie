package com.movie_admin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.movie_admin.vo.MemberBean;


public interface MemberDAO {

	List<MemberBean> getMember();

}
