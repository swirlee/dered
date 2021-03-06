package com.asjy.commerplat.service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.asjy.commerplat.model.User;



public interface IUserService {
	
	
	int adduser(String username, String password, String phone, String email, String realname, String sex, Boolean authority, Date addtime);

	User findbyid(int id);

	List<User> findAll();
	
	User findbyusernameandpassword(String username, String password);

	Boolean findByValidate(String validate,String ziduan);

	int addNewUser(User user);

	Boolean updatePassword(Map<String, Object> map, HttpSession session);

	Boolean findByUserAndValidate(String validate, String ziduan, HttpSession session);

	Boolean updateemail(Map<String, Object> map, HttpSession session);

	Boolean updatedetail(Map<String, Object> map, HttpSession session);

	int updateUser(User user);



}
